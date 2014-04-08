class TournamentsController < ApplicationController
  def index
    tournaments = Tournament.where(lol_region: params[:lol_region]).last(40)
    render json: tournaments
  end

  def create
    tournament = Tournament.new(tournament_params)

    if tournament.save
      render json: tournament
    else
      render json: { errors: tournament.errors }
    end
  end

  def show
    tournament = Tournament.find(params[:id])
    render json: tournament
  end

  def update
    tournament = Tournament.find(params[:id])

    if tournament.update_attributes(tournament_params)
      render json: tournament
    else
      render json: { errors: tournament.errors }
    end
  end

  def destroy
    tournament = Tournament.find(params[:id])
    if tournament.destroy
      render json: tournament
    else
      render json: { errors: tournament.errors }
    end
  end

  private

    def tournament_params
      params.require(:tournament).permit(:name, :description, :user_id, :lol_region)
    end
end
