class InvitationsController < ApplicationController
  def create
    if invitation_params[:team_id]
      invitation = Invitation.new(message: "#{Team.find(team_id)} has invited you to join their team.", user_id: invitation_params[:user_id], team_id: invitation_params[:team_id])
    elsif invitation_params[:tournament_id]
      # gotta deal with broadcasters & moderators
    end

    if invitation.save
      redirect_to request.referer, notice: 'Invite sent'
    else
      redirect_to request.referer, alert: invitation.errors.full_messages
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:user_id, :team_id, :tournament_id)
  end
end
