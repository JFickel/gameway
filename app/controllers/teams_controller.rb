class TeamsController < ApplicationController
  def index
    teams = Team.last(40)
    render json: teams
  end

  def show
    team = Team.find(params[:id])
    render json: team
  end
end
