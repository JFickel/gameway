class Users::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(user_params)

    if user.save
      render json: { authenticity_token: form_authenticity_token }
    else
      render json: { errors: user.errors}
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
