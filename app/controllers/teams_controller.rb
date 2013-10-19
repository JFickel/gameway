class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    team = Team.new(name: team_params[:name].split.map(&:capitalize).join(' '))
    team.team_memberships << TeamMembership.new(user_id: current_user)
    if team.save
      redirect_to team_path(team)
    else
      flash[:alert] = team.errors.full_messages
      redirect_to new_team_path
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
