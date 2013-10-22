class TournamentsController < ApplicationController
  before_action :tournament_params, only: [:create]
  def index
    if params[:query].present?
      @tournaments = Tournament.text_search(params[:query])
    else
      @tournaments = Tournament.all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @tournaments.map {|t| t.title } }
    end
  end

  def new
    @tournament = Tournament.new
  end

  def create
    tournament = Tournament.new(tournament_params)
    tournament.user_id = current_user.id
    if tournament.save
      redirect_to tournaments_path
    else
      flash[:alert] = user.errors.full_messages
      redirect_to new_tournament_path
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    @owner = @tournament.owner
    @moderator_role = ModeratorRole.new
    @tournament_membership = TournamentMembership.new
  end

  def update
    tournament = Tournament.find(params[:id])

    if params[:start]
      tournament.start
    elsif params[:position]
      tournament.advance(params[:position].map{|e| e.to_i })
    elsif params[:destroy]
      tournament.delete_slot(params[:delete_slot].map{|e| e.to_i })
    end

    tournament = Tournament.find(params[:id])

    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { render :json => tournament.bracket.map {|round| round.map {|match| match.user_showings.sort_by {|us| us.top ? 0 : 1 }.map {|us| us.user.username } if match != nil }}.to_json }
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:title, :game, :starts_on, :description, :rules)
  end
end
