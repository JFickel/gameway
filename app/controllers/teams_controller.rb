class TeamsController < ApplicationController
  def index
    if params[:query].present?
      @teams = Team.text_search(params[:query])
    else
      @teams = Team.all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @teams }
    end
  end

  def new
    @team = Team.new
  end

  def create
    team = Team.construct(team_params[:name])
    if team.save
      redirect_to team
    else
      redirect_to new_team_path, alert: team.errors.full_messages
    end
  end

  def show
    @team = Team.find(params[:id])
    @leader = @team.leader
    @members = @team.users - [@leader] ## member method
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
      redirect_to request.referrer, alert: team.errors.full_messages
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :avatar)
  end
end
