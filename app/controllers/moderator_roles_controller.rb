class ModeratorRolesController < ApplicationController
  def index

  end

  def create
    mod_role = ModeratorRole.new(moderator_role_params)

    if mod_role.save
      redirect_to request.referer, notice: "Successfully created moderator for tournament!"
    else
      redirect_to request.referer, alert: mod_role.errors.full_messages
    end
  end

  private

  def moderator_role_params
    params.require(:moderator_role).permit(:tournament_id, :user_id, :query)
  end
end
