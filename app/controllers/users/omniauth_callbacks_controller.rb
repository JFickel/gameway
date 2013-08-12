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
    # @user = User.find_for_omniauth(omniauth_response, current_user)
    @user = FindUserForOmniauth.call(omniauth_response)

    ### Probably a shitty idea to put this stuff in sessions?
    # if omniauth_response.try(:extra).try(:raw_info).try(:education).present?
    #   session[:education] = omniauth_response.extra.raw_info.education.each.with_object([]) do |education,obj|
    #     obj << [education.school.name, education.type]
    #   end
    # end


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
