class InvitationsController < ApplicationController
  def create
    invitation = Invitation.new(invitation_params)
    if invitation.save
      redirect_to request.referer, notice: 'Invite sent'
    else
      redirect_to request.referer, alert: invitation.errors.full_messages
    end
  end

  def destroy
    invitation = Invitation.find(params[:id])
    if invitation.user_id == current_user.id
      invitation.destroy
    end
    redirect_to request.referer
  end

  private

  def invitation_params
    params.require(:invitation).permit(:user_id, :team_id, :tournament_id, :sender_id)
  end
end
