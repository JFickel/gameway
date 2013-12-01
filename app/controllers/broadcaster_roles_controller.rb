class BroadcasterRolesController < ApplicationController
  def index
  end

  def create
    br = BroadcasterRole.new(broadcaster_role_params)

    if br.save
      Invitation.find_by(tournament_id: br.tournament_id, user_id: br.user_id, role: 'broadcaster').destroy
      redirect_to request.referer, notice: "Successfully added broadcaster for tournament!"
    else
      redirect_to request.referer, alert: br.errors.full_messages
    end
  end

  private

  def broadcaster_role_params
    params.require(:broadcaster_role).permit(:tournament_id, :user_id)
  end
end
