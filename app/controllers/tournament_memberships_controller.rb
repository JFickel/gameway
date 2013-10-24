class TournamentMembershipsController < ApplicationController
  def create
    member = current_user.tournament_memberships.new(tournament_membership_params)
    if member.save
      redirect_to request.referer, notice: "Successfully signed up for tournament!"
    else
      redirect_to request.referer, alert: member.errors.full_messages
    end
  end

  private

  def tournament_membership_params
    params.require(:tournament_membership).permit(:tournament_id)
  end
end
