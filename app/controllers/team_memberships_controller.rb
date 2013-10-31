class TeamMembershipsController < ApplicationController
  def create
    membership = TeamMembership.new(team_membership_params)

    if membership.save
      Invitation.find_by(team_id: membership.team_id, user_id: membership.user_id).destroy
      redirect_to request.referer, notice: "Successfully joined team!"
    else
      redirect_to request.referer, alert: membership.errors.full_messages
    end
  end

  def team_membership_params
    params.require(:team_membership).permit(:team_id, :user_id)
  end
end
