class UserShowingsController < ApplicationController
  def create
    UserShowing.create(params)
  end

  def update
    UserShowing.update_attributes(params)
  end

  def destroy
    UserShowing.destroy(params[:id])
  end
end
