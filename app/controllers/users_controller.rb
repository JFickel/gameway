class UsersController < ApplicationController
  def edit
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
  end

  private

  def user_params
    params.require(:user).permit(:login, :username, :first_name, :last_name,
    :email, :password, :password_confirmation, :remember_me, :avatar)
  end

end

