class SessionsController < Devise::SessionsController

  def new
  end

  def create
    render :update do |page|
      resource = warden.authenticate!(:scope => resource)
      flash[:notice] = I18n.t('devise.sessions.signed_in')
      page.redirect_to after_sign_in_path_for(current_user)
    end
  end


end
