class TournamentsController < ApplicationController
  before_action :tournament_params, only: [:create]
  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    tournament = Tournament.new(tournament_params)
    tournament.user_id = current_user.id
    if tournament.save
      redirect_to tournaments_path
    else
      flash[:alert] = user.errors.full_messages
      redirect_to new_tournament_path
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @tournament_member = TournamentMember.new
  end

  def update
    tournament = Tournament.find(params[:id])
    if params[:start]
      tournament.start
    end
    redirect_to request.referer
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :game, :start_time)
  end
end
