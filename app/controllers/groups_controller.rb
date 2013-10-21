class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group_membership = GroupMembership.new
    @group = Group.find_by(id: group_params)
  end

  def new
    @group = Group.new
  end

  private

  def group_params
    params.require(:id)
  end
end
