class TournamentsController < ApplicationController
  # Need to create user permissions
  def index
    params = {lol_region: "na", ended: false, limit: 40 }.merge(params.to_h)
    if params[:search]

    else
      tournaments = Tournament.where(lol_region: params[:lol_region], ended: params[:ended]).order(:starts_at).limit(params[:limit])
    end
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
      params.require(:tournament).permit(:name, :description, :user_id, :lol_region, :bracket_id, :started, :starts_at, :ended)
    end
end
