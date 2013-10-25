class TournamentsController < ApplicationController
  before_action :tournament_params, only: [:create]
  def index
    if params[:query].present?
      @tournaments = Tournament.text_search(params[:query])
    else
      @tournaments = Tournament.all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @tournaments }
    end
  end

  def new
    @tournament = Tournament.new
  end

  def create
    tournament = current_user.tournaments.new(tournament_params)
    if tournament.save
      redirect_to tournaments_path
    else
      flash[:alert] = tournament.errors.full_messages
      redirect_to new_tournament_path
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @owner = @tournament.owner
    @moderator_role = ModeratorRole.new
    @tournament_membership = TournamentMembership.new
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    tournament = Tournament.find(params[:id])
    tournament.start if params[:start]
    tournament.reload

    respond_to do |format|
      format.html { redirect_to tournament }
      format.json { render :json => tournament }
    end
  end

  def destroy
    tournament = Tournament.find(params[:id])
    tournament.destroy
    redirect_to request.referer
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :game, :starts_at, :description, :rules, :start_date, :start_hour, :start_minute, :start_period)
  end
end
