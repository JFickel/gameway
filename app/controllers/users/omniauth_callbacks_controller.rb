class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitchtv
    @user, flash[:first_twitch_auth] = User.find_for_twitchtv_oauth(request.env["omniauth.auth"])
    sign_in @user
    redirect_to root_path
  end
end
