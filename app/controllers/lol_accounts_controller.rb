require 'lol'

class LolAccountsController < ApplicationController
  def new
    fetch_summoner(lol_account_params)

    if @summoner
      render json: { summoner_id: @summoner.id }
    else
      render json: { error: @error }
    end
  end

  def create
    # should have summoner name, user id and region
    lol_account = LolAccount.new(lol_account_params)

    # then we should fetch the solo tier/solo rank and return succezz
  end

  private

    def lol_account_params
      params.require(:lol_account).permit(:summoner_name, :user_id, :region)
    end

    def fetch_summoner(lol_account_params)
      client = Lol::Client.new('490bf3bf-28f3-4397-baf8-30488fa1c76c', region: lol_account_params[:region])
      @summoner = client.summoner.by_name(lol_account_params[:summoner_name]).first
    rescue
      @error = "Could not find #{lol_account_params[:summoner_name]} in the #{lol_account_params[:region]} region."
    end
end
