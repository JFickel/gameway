class CompetitorshipsController < ApplicationController
  def create
    competitorships = Competitorship.new(competitorships_params)
    if competitorships.save
      render json: current_user
    else
      render json: { errors: competitorships.errors }
    end
  end

  private

    def competitorships_params
      params.require(:competitorships).permit(:user_id, :team_id, :tournament_id)
    end
end
