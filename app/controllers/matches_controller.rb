class MatchesController < ApplicationController
  def create
    Match.create(params)
  end

  def update
    Match.update_attributes(params)
  end

  def destroy
    Match.destroy(params[:id])
  end
end
