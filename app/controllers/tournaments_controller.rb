class TournamentsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]
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
    tournament = current_user.owned_tournaments.new(tournament_params)
    if tournament.save
      redirect_to tournaments_path
    else
      redirect_to new_tournament_path, alert: tournament.errors.full_messages
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @owner = @tournament.owner
    @tournament_membership = TournamentMembership.new
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def start
    tournament = Tournament.includes(:matches).find(params[:id])
    tournament.start if tournament_params[:start]
    redirect_to tournament
  end

  def update
    tournament = Tournament.includes(:matches).find(params[:id])

    if tournament.update_attributes(tournament_params)
      redirect_to tournament
    else
      redirect_to request.referer, alert: tournament.errors.full_messages
    end
  end

  def destroy
    tournament = Tournament.find(params[:id])
    tournament.destroy
    redirect_to request.referer
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :game, :starts_at, :description,
    :rules, :start_date, :start_hour, :start_minute, :start_period, :open, :open_applications, :start)
  end
end
