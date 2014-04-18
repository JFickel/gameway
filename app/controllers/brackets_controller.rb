class BracketsController < ApplicationController
  def show
    bracket = Bracket.find params[:id]
    render json: bracket
  end
end
