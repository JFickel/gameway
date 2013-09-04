class TournamentMembersController < ApplicationController
  def create
    member = TournamentMember.new(tournament_member_params)
    member.user_id = current_user.id
    if member.save
      flash[:notice] = "Successfully signed up for tournament!"
      redirect_to request.referer
    else
      flash[:alert] = member.errors.full_messages
      redirect_to request.referer
    end
  end

  private

  def tournament_member_params
    params.require(:tournament_member).permit(:tournament_id)
  end
end
