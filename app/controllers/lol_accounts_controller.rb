require 'lol'

class LolAccountsController < ApplicationController
  REGION_MAP = { 'na' => 'North America',
                 'br' => 'Brazil',
                 'eune' => 'EU Nordic & East',
                 'euw' => 'EU West',
                 'lan' => 'Latin America North',
                 'las' => 'Latin America South',
                 'oce' => 'Oceania'
                }

  def new
    fetch_summoner

    if @summoner
      render json: { summoner_id: @summoner.id, summoner_name: @summoner.name }
    else
      render json: { errors: @errors }
    end
  end

  def create
    # should have summoner name, user id and region
    @lol_account = LolAccount.where(user_id: lol_account_params[:user_id]).first_or_initialize
    @lol_account.assign_attributes(lol_account_params)

    if verify_summoner
      save_lol_account
      set_up_teams
      render json: @lol_account
    else
      render json: { errors: @errors }
    end
    # then we should fetch the solo tier/solo rank and return succezz
    # If I implement a create your own LoL team page, might want to consider stopping people from being annoying by stealing LoL team names
    # i.e. check if team with particular name/region already exists. if it does, stop them from creating that team.
  end

  private

    def lol_account_params
      params.require(:lol_account).permit(:summoner_name, :user_id, :region, :summoner_id)
    end

    def fetch_summoner
      if lol_account_params[:summoner_name].empty?
        @errors = ["Please enter a summoner name"]
        return
      end
      @client = Lol::Client.new('490bf3bf-28f3-4397-baf8-30488fa1c76c', region: lol_account_params[:region])
      @summoner = @client.summoner.by_name(lol_account_params[:summoner_name]).first
    rescue
      @errors = ["Could not find #{lol_account_params[:summoner_name]} in the #{REGION_MAP[lol_account_params[:region]]} region."]
    end

    def verify_summoner
      @client = Lol::Client.new('490bf3bf-28f3-4397-baf8-30488fa1c76c', region: lol_account_params[:region])
      rune_pages = @client.summoner.runes(lol_account_params[:summoner_id]).first.last
      if rune_pages.find { |page| page.name == params[:verification_code] }
        true
      else
        @errors = ["Unable to find a rune page with the verification code. Riot's servers may be propagating changes slowly. If you are sure that you correctly renamed the page, try verifying again in a few seconds."]
        return false
      end
    end

    def save_lol_account
      entries = @client.league.get_entries(lol_account_params[:summoner_id])
      if solo_entry = entries.find { |entry| entry.queue_type == "RANKED_SOLO_5x5" }
        @lol_account.solo_tier = solo_entry.tier
        @lol_account.solo_rank = solo_entry.rank
      end
      @lol_account.save
    end

    def set_up_teams
      lol_teams = @client.team.get(lol_account_params[:summoner_id])
      lol_teams.each do |lol_team|
        team = Team.where(lol_region: lol_account_params[:region], name: lol_team.name).first_or_create
        next if team.leader == current_user or team.members.include? current_user

        if lol_team.roster.owner_id == lol_account_params[:summoner_id].to_i
          team.leader = current_user
        elsif team.leader
          team.members << current_user
        else
          team.leader = current_user
        end

        team.save
      end
    end
end
