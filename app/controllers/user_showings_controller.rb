class UserShowingsController < ApplicationController
  def create
    UserShowing.create(user_showing_params)
    render json: user_showing
  end

  def update
    user_showing = UserShowing.find(params[:id])
    user_showing.update_attributes(user_showing_params)
    render json: user_showing
  end

  def destroy
    UserShowing.destroy(params[:id])
  end

  private

  def user_showing_params
    params.require(:user_showing).permit(:user_id, :match_id, :top)
  end
end
