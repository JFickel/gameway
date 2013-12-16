class TeamShowingsController < ApplicationController
  def create
    TeamShowing.create(params)
  end

  def update
    TeamShowing.update_attributes(params)
  end

  def destroy
    TeamShowing.destroy(params[:id])
  end
end
