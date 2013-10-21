class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group_membership = GroupMembership.new
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(name: group_params[:name])
    group.group_memberships << GroupMembership.new(user_id: current_user.id)
    if group.save
      redirect_to group_path(group)
    else
      flash[:alert] = group.errors.full_messages
      redirect_to new_team_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:id, :name)
  end
end
