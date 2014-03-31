class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :lol_region, :user_id
end
