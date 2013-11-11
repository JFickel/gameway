require 'twitch'
class UsersController < ApplicationController
  def index
    @users = User.text_search(params[:query]).limit(20) ## don't brogram for da future

    respond_to do |format|
      format.html
      format.json { render :json => @users }
    end
  end

  def edit
    @starcraft2_account = current_user.starcraft2_account || Starcraft2Account.new
    @twitch_account = current_user.twitch_account || TwitchAccount.new
    @lol_account = current_user.lol_account || LolAccount.new
  end

  def update
    user = User.find(current_user)
    if user.update_attributes(user_params)
      if user_params[:avatar]
        redirect_to request.referrer
      else
        redirect_to root_path
      end
    else
      flash[:errors] = user.errors.full_messages
      redirect_to request.referrer
    end
  end

  def show
    @user = User.find(params[:id])
    @uploader = @user.avatar
    @twitch = Twitch.new(@user.twitch_account.try(:username))
  end

  private

  def user_params
    params.require(:user).permit(:login, :username, :first_name, :last_name,
    :email, :password, :password_confirmation, :remember_me, :avatar)
  end

end

