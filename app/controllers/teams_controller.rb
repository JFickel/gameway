class TeamsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :index]
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
    team = Team.construct(name: team_params[:name], leader: current_user)
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

    # client = Twitter::Client.new do |config|
    #   config.consumer_key        = "ZnSuxvrL2l33nGsLYFuQ"
    #   config.consumer_secret     = "kxKBXZZPYHpYdJO4TCnVtPahO1cgaKmlK2ToHbHsDM"
    #   config.access_token        = "864007722-IurWwUPqZJ5Gk8IAQBRmQcOIrCX09pZZijgbseWu"
    #   config.access_token_secret = "Aqgl81erxBiFZ5SIzIYtCyOSY5fBcxFOEBmM1LossAQ8i"
    # end
  end

  def edit
    @team = Team.find(params[:id])
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
