class TournamentMembershipsController < ApplicationController
  # def track_membership_creation(tournament_membership)
  #   Analytics.track(
  #     user_id: current_user.id,
  #     event: 'Joined Tournament',
  #     properties: { tournament_id: tournament_membership.tournament_id,
  #                   tournament_membership_id: tournament_membership.id,
  #                   team_id: tournament_membership.team_id },
  #     context: {
  #       'Google Analytics' => {clientId: request.cookies['_ga'].split('.')[2..4].join('.')}
  #     })
  # end

  def create
    if tournament_membership_params[:team_id]
      member = Team.find(tournament_membership_params[:team_id]).tournament_memberships.new(tournament_id: tournament_membership_params[:tournament_id])
      member.team.add_tournament_event(Tournament.find(tournament_membership_params[:tournament_id]))
    elsif tournament_membership_params[:user_id]
      member = current_user.tournament_memberships.new(tournament_id: tournament_membership_params[:tournament_id])
    end

    respond_to do |format|
      if member.save
      # track_membership_creation(member)
        format.json { render json: { flash: {notice: "Successfully signed up for tournament!"}}}
        # redirect_to request.referer, notice: "Successfully signed up for tournament!"
      else
        format.json { render json: {flash: {alert: member.errors.full_messages}}}
        # redirect_to request.referer, alert: member.errors.full_messages
      end
    end
  end

  private

  def tournament_membership_params
    params.require(:tournament_membership).permit(:tournament_id, :team_id, :user_id)
  end
end
