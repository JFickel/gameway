class TournamentMembershipsController < ApplicationController
  def create
    if tournament_membership_params[:team]
      member = Team.find(tournament_membership_params[:team_id]).tournament_memberships.new(tournament_id: tournament_membership_params[:tournament_id])
    else
      member = current_user.tournament_memberships.new(tournament_membership_params)
    end

    if member.save
      redirect_to request.referer, notice: "Successfully signed up for tournament!"
    else
      redirect_to request.referer, alert: member.errors.full_messages
    end
  end

  private

  def tournament_membership_params
    params.require(:tournament_membership).permit(:tournament_id, :team_id)
  end
end
