class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url, :leader

  def avatar_url
    "#{object.avatar.icon.url}"
  end
end
