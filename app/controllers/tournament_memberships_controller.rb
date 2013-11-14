class TournamentMembershipsController < ApplicationController
  # def track_membership_creation(tournament_membership)
  #   Analytics.track(
  #     user_id: current_user.id,
  #     event: 'Joined Tournament',
  #     properties: { tournament_id: tournament_membership.tournament_id, tournament_membership_id: tournament_membership.id, team_id: tournament_membership.team_id })
  # end

  def create
    if tournament_membership_params[:team_id]
      member = Team.find(tournament_membership_params[:team_id]).tournament_memberships.new(tournament_id: tournament_membership_params[:tournament_id])
      member.team.add_tournament_event(Tournament.find(tournament_membership_params[:tournament_id]))
    else
      member = current_user.tournament_memberships.new(tournament_membership_params)
    end

    if member.save
      # track_membership_creation
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
