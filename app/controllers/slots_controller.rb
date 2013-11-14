class SlotsController < ApplicationController
  def create
    tournament = Tournament.includes(:matches).find(params[:id])
    BracketController.new(tournament).advance(params[:position].map{|e| e.to_i })
    tournament.reload
    render json: tournament
  end

  def destroy
    tournament = Tournament.includes(:matches).find(params[:id])
    BracketController.new(tournament).delete_slot(params[:destroy].map{|e| e.to_i })
    tournament.reload
    render json: tournament
  end
end
