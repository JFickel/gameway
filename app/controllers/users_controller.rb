class UsersController < ApplicationController
  # def google_oauth2
  #   login_omniauth_user "Google"
  # end

  # def facebook
  #   login_omniauth_user "Facebook"
  # end

  # def twitter
  #   login_omniauth_user "Twitter"
  # end

  private

  def user_params
    params.require(:user).permit(:login, :username,
      :email, :password, :password_confirmation,
      :remember_me)
  end

  # def login_omniauth_user(service)
  #   @user = User.find_for_omniauth(request.env["omniauth.auth"], current_user)

  #   if @user.persisted?
  #     flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => service
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     flash[:notice] = I18n.t("users.finish_signup")
  #     session["devise.omniauth_data"] = request.env["omniauth.auth"].except("extra")
  #     redirect_to new_user_registration_url
  #   end
  # end
end
