require 'find_user_for_omniauth'
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitch_oauth2
    login_omniauth_user "Twitch"
  end

  def facebook
    login_omniauth_user "Facebook"
  end

  private

  def login_omniauth_user(service)
    omniauth_response = request.env["omniauth.auth"]

    @user = FindUserForOmniauth.call(omniauth_response)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => service
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = I18n.t("users.finish_signup")
      session["devise.omniauth_data"] = request.env["omniauth.auth"].except("extra")
      render template: 'devise/registrations/new'
    end
  end
end
