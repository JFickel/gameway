class SlotsController < ApplicationController
  def create
    tournament = Tournament.includes(:matches).find(params[:id])
    position = calculate_position(tournament, params[:showing_id].to_i)
    BracketController.new(tournament).advance(position)
    tournament.reload
    render json: tournament, scope: current_user
  end



  def destroy
    tournament = Tournament.includes(:matches).find(params[:id])
    position = calculate_position(tournament, params[:showing_id].to_i)
    BracketController.new(tournament).delete_slot(position)
    tournament.reload
    render json: tournament, scope: current_user
  end

  def calculate_position(tournament, showing_id)
    tournament.bracket.each.with_index do |round, ri|
      round.compact.each.with_index do |match, mi|
        match.showings.each do |showing|
          if showing.id == showing_id
            si = showing.top ? 0 : 1
            return [ri, mi, si]
          end
        end
      end
    end
  end
end
