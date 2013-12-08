class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_timezone

  def after_sign_up_path_for(resource)
    edit_user_path(current_user)
  end

  def after_sign_in_path_for(resource)
    request.referer
  end

  def after_sign_out_path_for(resource)
    request.referer
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password) }
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.slice(:username, :email, :password, :password_confirmation, :group_ids).permit!
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :avatar) }
  end

  private

  def set_timezone
    Time.zone = session[:time_zone] if session[:time_zone]
  end
end
