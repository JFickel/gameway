class Users::PasswordsController < Devise::PasswordsController
  skip_before_filter :require_no_authentication
  def update
    user = User.find(params[:id])

    if current_user == user # || current_user.admin?
      if user.update_with_password(user_params)
        render json: user
      else
        render json: { errors: user.errors }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
