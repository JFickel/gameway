class LolAccountSerializer < ApplicationSerializer
  attributes :id, :user_id, :summoner_id, :summoner_name, :solo_tier, :solo_rank, :region
end
