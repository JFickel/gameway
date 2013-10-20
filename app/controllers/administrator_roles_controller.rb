class AdministratorRolesController < ApplicationController
  def create
    admin_role = AdministratorRole.new(administrator_role_params)
    if admin_role.save
      flash[:notice] = "Successfully created admin for tournament!"
      redirect_to request.referer
    else
      flash[:alert] = member.errors.full_messages
      redirect_to request.referer
    end
  end

  private

  def administrator_role_params
    params.require(:administrator_role).permit(:tournament_id, :user_id)
  end
end
