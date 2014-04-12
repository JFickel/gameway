class TournamentSerializer < ApplicationSerializer
  attributes :id, :name, :description, :lol_region, :created_at, :updated_at, :user_id, :started, :starts_at

  has_one :user
  has_many :teams
  has_one :bracket
end
