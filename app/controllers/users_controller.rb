class UsersController < ApplicationController
  def index
    @users = User.all
  end


  private

  def user_params
    params.require(:user).permit(:login, :username,
      :email, :password, :password_confirmation,
      :remember_me)
  end
end
