class PasswordsController < Devise::PasswordsController

  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    if successful_and_sane?(resource)
      flash[:notice] = I18n.t('devise.passwords.send_instructions')
      render :update do |page|
        page.redirect_to root_path
      end
    else
      render :update do |page|
        page << "$('#error3').html('Invalid Email');"
      end
    end
  end

  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
  end
end
