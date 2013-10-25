class SlotsController < ApplicationController
  def create
    tournament = Tournament.find(params[:id])
    tournament.advance(params[:position].map{|e| e.to_i })
    tournament.reload
    render json: tournament
  end

  def destroy
    tournament = Tournament.find(params[:id])
    tournament.delete_slot(params[:destroy].map{|e| e.to_i })
    tournament.reload
    render json: tournament
  end
end
