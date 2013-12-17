class UserShowingsController < ApplicationController
  def create
    if user_showing = UserShowing.create(user_showing_params)
      render json: user_showing
    end
  end

  def update
    user_showing = UserShowing.find(params[:id])
    if UserShowing.update_attributes(user_showing_params)
      render json: user_showing
    end
  end

  def destroy
    UserShowing.destroy(params[:id])
  end

  private

  def user_showing_params
    params.require(:user_showing).permit(:user_id, :match_id, :top)
  end
end
