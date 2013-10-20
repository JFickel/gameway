class GroupMembershipsController < ApplicationController
  def create
    member = GroupMembership.new(group_membership_params)
    member.user_id = current_user.id
    if member.save
      flash[:notice] = "Successfully joined #{member.group.name}!"
      redirect_to request.referer
    else
      flash[:alert] = member.errors.full_messages
      redirect_to request.referer
    end
  end

  private

  def group_membership_params
    params.require(:group_membership).permit(:group_id)
  end
end
