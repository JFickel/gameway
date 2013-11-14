class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url

  def avatar_url
    "#{object.avatar.icon.url}"
  end
end
