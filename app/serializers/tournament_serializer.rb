class TournamentSerializer < ApplicationSerializer
  attributes :id, :name, :description, :lol_region, :created_at, :updated_at
end
