class RoundSerializer < ApplicationSerializer
  attributes :id, :index, :bracket_id

  has_many :matches
end
