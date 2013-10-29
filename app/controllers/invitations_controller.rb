class InvitationsController < ApplicationController
  def create
    if invitation_params[:team_id]
      invitation = Invitation.new(message: "#{Team.find(invitation_params[:team_id]).name} has invited you to join their team.", user_id: invitation_params[:user_id], team_id: invitation_params[:team_id])
    elsif invitation_params[:tournament_id]
      # gotta deal with broadcasters & moderators
    end

    if user_is_not_in_team_already(invitation_params) && invitation.save
      redirect_to request.referer, notice: 'Invite sent'
    else
      redirect_to request.referer, alert: invitation.errors.full_messages, notice: 'Cannot invite user already in your team'
    end
  end

  def destroy
    invitation = Invitation.find(params[:id])
    if invitation.user_id == current_user.id
      invitation.destroy
    end
    redirect_to request.referer
  end

  def user_is_not_in_team_already(invitation_params)
    team = Team.find(invitation_params[:team_id])
    user = User.find(invitation_params[:user_id])
    return false if team.users.include? user
    return true
  end

  private

  def invitation_params
    params.require(:invitation).permit(:user_id, :team_id, :tournament_id)
  end
end
