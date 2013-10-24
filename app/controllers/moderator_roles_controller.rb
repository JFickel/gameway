class ModeratorRolesController < ApplicationController
  def index
    if moderator_role_params[:query].present?
      @users = User.text_search(moderator_role_params[:query]) ## don't brogram for da future
    end

    respond_to do |format|
      format.html
      format.json { render :json => @users.map {|u| ["#{u.username} - #{u.first_name} #{u.last_name}", u.id]} }
    end
  end

  def create
    debugger
    mod_role = ModeratorRole.new(moderator_role_params)
    if mod_role.save
      flash[:notice] = "Successfully created moderator for tournament!"
      redirect_to request.referer
    else
      flash[:alert] = member.errors.full_messages
      redirect_to request.referer
    end
  end

  private

  def moderator_role_params
    params.require(:moderator_role).permit(:tournament_id, :user_id, :query)
  end
end
