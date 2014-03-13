class TournamentsController < ApplicationController
  def index
    tournaments = Tournament.last(40)
    render json: tournaments
  end

  def create
    tournament = Tournament.new(tournament_params)

    if tournament.save
      render status: 200
    else
      render status: 403
    end
  end

  def show
    tournament = Tournament.find(params[:id])
    render json: tournament
  end

  def update
    tournament = Tournament.find(params[:id])

    if tournament.update_attributes(tournament_params)
      render status: 200
    else
      render status: 403
    end
  end

  def destroy
    tournament = Tournament.find(params[:id])
    if tournament.destroy
      render status: 200
    else
      render status: 403
    end
  end

  private

    def tournament_params
      params.require(:tournament).permit(:title, :description)
    end
end
