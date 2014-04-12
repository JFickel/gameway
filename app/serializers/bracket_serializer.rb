class BracketSerializer < ApplicationSerializer
  attributes :id, :tournament_id, :mode

  has_many :rounds
end
