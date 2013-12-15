class TournamentsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :index]
  before_action :tournament_params, only: [:create]

  def track_tournament_creation(tournament)
    Analytics.track(
      user_id: current_user.id,
      event: 'Created Tournament',
      properties: { mode: tournament.mode, game: tournament.game },
      context: {
        'Google Analytics' => {clientId: request.cookies['_ga'].split('.')[2..4].join('.')}
      }
    )
  end

  def index
    @tournaments = Rails.cache.fetch("text_search_#{params[:query]}") do
      if params[:query].present?
        Tournament.text_search(params[:query]).includes(:matches => :users)
      else
        Tournament.all
      end
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
      track_tournament_creation(tournament)
      redirect_to tournaments_path
    else
      redirect_to new_tournament_path, alert: tournament.errors.full_messages
    end
  end

  def show
    @tournament, @owner, @tournament_membership = Rails.cache.fetch("tshow_#{params[:id]}") do
      tournament = Tournament.where(:id => params[:id]).includes(:matches => [:users, :user_showings]).first
      owner = tournament.owner
      tm = TournamentMembership.new
      [tournament, owner, tm]
    end
    # @opponent = @tournament.current_opponent(current_user)
    @tournament.reload

    respond_to do |format|
      format.html
      format.json { render json: @tournament, scope: current_user }
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def start
    tournament = Tournament.includes(:matches).find(params[:id])
    tournament.start if tournament_params[:start]
    render json: tournament, scope: current_user
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
    :rules, :start_date, :start_hour, :start_minute, :start_period, :open, :open_applications, :start, :mode)
  end
end
