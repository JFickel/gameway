class Users::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(user_params)

    if user.save
      render json: { authenticity_token: form_authenticity_token }
    else
      render json: { errors: user.errors}
    end
  end

  # def update
  #   user = User.find_by(id: params[:id])
  #
  #   if user == current_user # || current_user.admin?
  #
  #   end
  #
  #
  # end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
