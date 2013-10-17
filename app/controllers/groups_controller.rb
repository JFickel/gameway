class GroupsController < ApplicationController
  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find_by(id: group_params)
  end

  def group_params
    params.require(:id)
  end
end
