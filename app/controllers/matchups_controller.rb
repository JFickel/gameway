require 'HTTParty'

class MatchupsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:lol_advance]

  def lol_advance
    match_id = params["tournamentMetaData"]["passbackDataPacket"]
    match = Match.find(match_id)

    winning_players = params["teamPlayerParticipantsSummaries"].select do |player|
      player["isWinningTeam"]
    end

    match.teams.each do |team|
      if team.all_users.any? { |user| winning_players.include?(user.lol_account.summoner_name) }
        winning_team = team
      end
    end

    matchup = Matchup.find(match.next_matchup_id)
    matchup.update_attributes(team: winning_team)
    HTTParty.put("https://gameway.firebaseio.com/brackets/#{match.round.bracket.id}/matchup_updates/#{matchup.id}.json",
                 body: { team_id: winning_team.id, id: matchup.id }.to_json)
    render status: 200
  end

  def update
    matchup = Matchup.find(params[:id])

    if matchup.update_attributes(matchup_params)
      HTTParty.put("https://gameway.firebaseio.com/brackets/#{matchup.match.round.bracket.id}/matchup_updates/#{matchup.id}.json",
                   body: { team_id: matchup.team_id, id: matchup.id }.to_json)
      render json: matchup
    else
      render json: { errors: matchup.errors }
    end
  end

  private

  def matchup_params
    # It's probably not needed to permit all of these attributes, but whatever
    params.require(:matchup).permit(:team_id, :user_id, :match_id, :top, :origin)
  end
end
