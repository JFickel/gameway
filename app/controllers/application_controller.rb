class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :inject_current_user_js, :inject_csrf_token

  def inject_csrf_token
    gon.authenticity_token = session['_csrf_token']
  end

  def inject_current_user_js
    gon.current_user = current_user
    gon.user_signed_in = user_signed_in?
  end
end
