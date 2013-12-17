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

  private

  def team_showing_params
    params.require(:team_showing_params).permit(:team_id, :match_id, :top)
  end
end
