class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :inject_current_user_js

  def inject_current_user_js
    gon.current_user = current_user
    gon.user_signed_in = user_signed_in?
  end
end
