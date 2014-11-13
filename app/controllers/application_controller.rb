class ApplicationController < ActionController::Base
  protect_from_forgery
  helper:all
  helper_method :after_sign_in_path_for

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      if current_user.role == 'client'
        clients_clients_path
      elsif current_user.role == 'creative'
        creatives_creatives_path
      elsif current_user.role == 'tutor'
        tutors_tutors_path
      elsif current_user.role == 'visitor'
        visitors_visitors_path
      end
    end
  end

  def is_login?
    unless current_user
      flash[:error] = "Please login"
      redirect_to '/'
    end
  end

  def is_admin?
    unless current_user.role == 'admin'
      flash[:error] = "Permission Denied"
      redirect_to '/'
    end
  end

  def is_client?
    unless current_user.role == 'client'
      flash[:error] = "Permission Denied"
      redirect_to '/'
    end
  end
end
