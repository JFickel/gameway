class ModeratorRolesController < ApplicationController
  def index
    if params[:query].present?
      @users = User.text_search(params[:query])
    end

    respond_to do |format|
      format.html
      format.json { render :json => @users.map {|u| "#{u.username} - #{u.first_name} #{u.last_name}"} }
    end
  end

  def create
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
    params.require(:moderator_role).permit(:tournament_id, :user_id)
  end
end
