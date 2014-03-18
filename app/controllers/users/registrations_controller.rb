class Users::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(user_params)

    if user.save
      # output = JSON.parse(UserSerializer.new(user).to_json)
      # output[:authenticity_token] = form_authenticity_token
      render json: { authenticity_token: form_authenticity_token }
    else
      render json: { errors: user.errors}
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
