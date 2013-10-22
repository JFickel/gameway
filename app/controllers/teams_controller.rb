class TeamsController < ApplicationController
  def index
    if params[:query].present?
      @teams = Team.text_search(params[:query])
    else
      @teams = Team.all
    end
  end

  def new
    @team = Team.new
  end

  def create
    team = Team.new(name: team_params[:name])
    team.team_memberships << TeamMembership.new(user_id: current_user.id)
    team.leader = current_user
    if team.save
      redirect_to team_path(team)
    else
      flash[:alert] = team.errors.full_messages
      redirect_to new_team_path
    end
  end

  def show
    @team = Team.find(params[:id])
    @leader = @team.leader
    @members = @team.users - [@leader]
  end

  def update
    team = Team.find(params[:id])
    if team.update_attributes(team_params)
      if team_params[:avatar]
        redirect_to request.referer
      else
        redirect_to team_path(team)
      end
    else
      flash[:alert] = team.errors.full_messages
      redirect_to request.referrer
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :avatar)
  end
end
