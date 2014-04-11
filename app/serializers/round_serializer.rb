class RoundSerializer < ActiveModel::Serializer
  attributes :id, :index, :bracket_id

  has_many :matches
end
