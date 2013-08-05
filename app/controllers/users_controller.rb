class UsersController < ApplicationController
  before_filter :configure_permitted_parameters
  def edit
  end

  def update
    user_params
    user = User.find(current_user)
    if user.update_attributes(params[:user])
      redirect_to root_path
    else
      flash[:errors] = user.errors.full_messages
      redirect_to request.referrer
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :username, :first_name, :last_name,
    :email, :password, :password_confirmation, :remember_me)
  end

end
