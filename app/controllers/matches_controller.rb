class MatchesController < ApplicationController
  def create
    if match = Match.create(match_params)
      render json: match
    end
  end

  def update
    match = Match.find(params[:id])
    if match.update_attributes(match_params)
      render json: match
    end

  end

  def destroy
    if Match.destroy(params[:id])
      render status: 200
    end
  end

  private

  def match_params
    params.require(:match).permit(:tournament_id)
  end
end
