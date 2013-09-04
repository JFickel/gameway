class TournamentMembersController < ApplicationController
  def create
    tm = TournamentMember.new(tournament_member_params)
    tm.user_id = current_user.id
    if tm.save
      flash[:notice] = "Successfully signed up for tournament!"
      redirect_to request.referer
    else
      flash[:errors] = tm.errors.full_messages
      redirect_to request.referer
    end
  end

  private

  def tournament_member_params
    params.permit(:tournament_id)
  end
end
