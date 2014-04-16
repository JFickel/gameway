class MatchesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:lol_advance]

  def lol_advance
    match_id = params["tournamentMetaData"]["passbackDataPacket"]
    match = Match.find(match_id)

    winning_players = ["teamPlayerParticipantsSummaries"].select do |player|
      player["isWinningTeam"]
    end
    match.teams.each do |team|
      if team.all_users.any? { |user| winning_players.include?(user.lol_account.summoner_name) }
        winning_team = team
      end
    end
    Matchup.find(match.next_matchup_id).update_attributes(team: winning_team)
    render status: 200
  end

# {"version"=>1,
#  "tournamentMetaData"=>
#   {"passbackDataPacket"=>"11",
#    "passbackUrl"=>"https://gameway.fwd.wf/matches/advance"},
#  "gameId"=>1347147588,
#  "gameLength"=>1318,
#  "gameType"=>"CUSTOM_GAME",
#  "ranked"=>false,
#  "invalid"=>false,
#  "gameMode"=>"CLASSIC",
#  "teamPlayerParticipantsSummaries"=>
#   [{"level"=>30,
#     "teamId"=>100,
#     "isWinningTeam"=>true,
#     "leaver"=>false,
#     "summonerName"=>"nigrett",
#     "skinName"=>"Anivia",
#     "profileIconId"=>585,
#     "botPlayer"=>false,
#     "spell1Id"=>4,
#     "spell2Id"=>14,
#     "statistics"=>
#      [{"value"=>4273,
#        "statTypeName"=>"PHYSICAL_DAMAGE_TAKEN",
#        "m_nDataVersion"=>0},
#       {"value"=>448,
#        "statTypeName"=>"LARGEST_CRITICAL_STRIKE",
#        "m_nDataVersion"=>0},
#       {"value"=>0, "statTypeName"=>"ITEM6", "m_nDataVersion"=>0},
#       {"value"=>0, "statTypeName"=>"TRUE_DAMAGE_TAKEN", "m_nDataVersion"=>0},
#       {"value"=>1785,
#        "statTypeName"=>"TOTAL_TIME_CROWD_CONTROL_DEALT",
#        "m_nDataVersion"=>0},
#       {"value"=>3003, "statTypeName"=>"ITEM1", "m_nDataVersion"=>0},
#       {"value"=>3020, "statTypeName"=>"ITEM0", "m_nDataVersion"=>0},
#       {"value"=>79, "statTypeName"=>"MINIONS_KILLED", "m_nDataVersion"=>0},
#       {"value"=>1854,
#        "statTypeName"=>"MAGIC_DAMAGE_TAKEN",
#        "m_nDataVersion"=>0},
#       {"value"=>3,
#        "statTypeName"=>"NEUTRAL_MINIONS_KILLED_ENEMY_JUNGLE",
#        "m_nDataVersion"=>0},
#       {"value"=>1, "statTypeName"=>"WIN", "m_nDataVersion"=>0},
#       {"value"=>68227,
#        "statTypeName"=>"TOTAL_DAMAGE_DEALT",
#        "m_nDataVersion"=>0},
#       {"value"=>3,
#        "statTypeName"=>"NEUTRAL_MINIONS_KILLED_YOUR_JUNGLE",
#        "m_nDataVersion"=>0},
#       {"value"=>2003, "statTypeName"=>"ITEM3", "m_nDataVersion"=>0},
#       {"value"=>51803,
#        "statTypeName"=>"MAGIC_DAMAGE_DEALT_PLAYER",
#        "m_nDataVersion"=>0},
#       {"value"=>844, "statTypeName"=>"TOTAL_HEAL", "m_nDataVersion"=>0},
#       {"value"=>334,
#        "statTypeName"=>"TRUE_DAMAGE_DEALT_PLAYER",
#        "m_nDataVersion"=>0},
#       {"value"=>1886,
#        "statTypeName"=>"PHYSICAL_DAMAGE_DEALT_TO_CHAMPIONS",
#        "m_nDataVersion"=>0},
#       {"value"=>1, "statTypeName"=>"ASSISTS", "m_nDataVersion"=>0},
#       {"value"=>16089,
#        "statTypeName"=>"PHYSICAL_DAMAGE_DEALT_PLAYER",
#        "m_nDataVersion"=>0},
#       {"value"=>0,
#        "statTypeName"=>"SIGHT_WARDS_BOUGHT_IN_GAME",
#        "m_nDataVersion"=>0},
#       {"value"=>0, "statTypeName"=>"WARD_KILLED", "m_nDataVersion"=>0},
#       {"value"=>2, "statTypeName"=>"LARGEST_MULTI_KILL", "m_nDataVersion"=>0},
#       {"value"=>10, "statTypeName"=>"LEVEL", "m_nDataVersion"=>0},
#       {"value"=>0, "statTypeName"=>"WARD_PLACED", "m_nDataVersion"=>0},
#       {"value"=>6127,
#        "statTypeName"=>"TOTAL_DAMAGE_TAKEN",
#        "m_nDataVersion"=>0},
#       {"value"=>11611,
#        "statTypeName"=>"MAGIC_DAMAGE_DEALT_TO_CHAMPIONS",
#        "m_nDataVersion"=>0},
#       {"value"=>0,
#        "statTypeName"=>"TOTAL_TIME_SPENT_DEAD",
#        "m_nDataVersion"=>0},
#       {"value"=>0, "statTypeName"=>"BARRACKS_KILLED", "m_nDataVersion"=>0},
#       {"value"=>1026, "statTypeName"=>"ITEM2", "m_nDataVersion"=>0},
#       {"value"=>4,
#        "statTypeName"=>"LARGEST_KILLING_SPREE",
#        "m_nDataVersion"=>0},
#       {"value"=>0, "statTypeName"=>"ITEM5", "m_nDataVersion"=>0},
#       {"value"=>334,
#        "statTypeName"=>"TRUE_DAMAGE_DEALT_TO_CHAMPIONS",
#        "m_nDataVersion"=>0},
#       {"value"=>6,
#        "statTypeName"=>"NEUTRAL_MINIONS_KILLED",
#        "m_nDataVersion"=>0},
#       {"value"=>13831,
#        "statTypeName"=>"TOTAL_DAMAGE_DEALT_TO_CHAMPIONS",
#        "m_nDataVersion"=>0},
#       {"value"=>0, "statTypeName"=>"ITEM4", "m_nDataVersion"=>0},
#       {"value"=>6420, "statTypeName"=>"GOLD_EARNED", "m_nDataVersion"=>0},
#       {"value"=>0,
#        "statTypeName"=>"VISION_WARDS_BOUGHT_IN_GAME",
#        "m_nDataVersion"=>0},
#       {"value"=>4, "statTypeName"=>"CHAMPIONS_KILLED", "m_nDataVersion"=>0},
#       {"value"=>2, "statTypeName"=>"TURRETS_KILLED", "m_nDataVersion"=>0},
#       {"value"=>0, "statTypeName"=>"NUM_DEATHS", "m_nDataVersion"=>0}]}],
#        "otherTeamPlayerParticipantsSummaries"=>nil,
#        "match"=>{}}

end
