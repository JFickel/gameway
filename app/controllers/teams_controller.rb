class TeamsController < ApplicationController
  def index
    teams = Team.last(40)
    render json: teams
  end
end
