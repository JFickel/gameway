class MatchSerializer < ApplicationSerializer
  attributes :id, :matchups

  def matchups
    object.matchups
  end
end
