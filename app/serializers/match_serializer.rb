class MatchSerializer < ApplicationSerializer
  attributes :id, :round_id, :next_matchup_id, :index

  has_many :matchups
end
