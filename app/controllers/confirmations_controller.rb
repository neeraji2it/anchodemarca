class ConfirmationsController < Devise::ConfirmationsController

  def new
    build_resource({})
    render_with_scope :new
  end

  def create
    self.resource = resource_class.send_confirmation_instructions(params[resource_name])
    @user = User.find(:first, :conditions => ["email = ?", params[:user][:email].strip])
    #    if successful_and_sane?(resource)
    if @user and @user.confirmed_at.nil?
      flash[:notice] = I18n.t('devise.confirmations.send_instructions')
      render :update do |page|
        page.redirect_to  root_path
      end
    else
      render :update do |page|
        if  @user
          page<<"$('#confirmation_error').html('Email was already confirmed, please try signing in');"
        else
          page<<"$('#confirmation_error').html('Email not Found');"
        end
      end
    end
  end

end