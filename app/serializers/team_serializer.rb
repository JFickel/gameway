class TeamSerializer < ApplicationSerializer
  attributes :id, :name, :lol_region, :user_id

  has_many :matchups
end
