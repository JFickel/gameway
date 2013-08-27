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
    if tournament.save
      redirect_to tournaments_path
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_tournament_path
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :game, :start_time)
  end
end
