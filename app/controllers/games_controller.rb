class GamesController < ApplicationController
  before_filter :is_admin?

  def is_admin?
    unless current_user.admin?
      redirect_to root_path, alert: 'You are not an admin'
    end
  end

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    game = Game.new(game_params)
    if game.save
      redirect_to games_path
    else
      redirect_to new_game_path, alert: game.errors.full_messages
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    game = Game.find(params[:id])
    if game.update_attributes(game_params)
      redirect_to game
    else
      redirect_to edit_game_path(game), alert: game.errors.full_messages
    end
  end

  def destroy
    game = Game.find(params[:id]).destroy
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :avatar)
  end
end
