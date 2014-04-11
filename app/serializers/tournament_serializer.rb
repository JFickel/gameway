class TournamentSerializer < ApplicationSerializer
  attributes :id, :name, :description, :lol_region, :created_at, :updated_at, :bracket

  has_many :teams

  def bracket
    object.structure
  end
end
