class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render *args
    inject_csrf_token
    inject_current_user_js
    inject_asset_path
    super
  end

  def inject_csrf_token
    gon.authenticity_token = form_authenticity_token
  end

  def inject_current_user_js
    gon.current_user_payload = UserSerializer.new(current_user).as_json
    gon.user_signed_in = user_signed_in?
  end

  def inject_asset_path
    gon.image_path = ActionController::Base.helpers.asset_path('.')
  end
end
