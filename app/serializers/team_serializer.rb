class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url, :leader, :team_url

  def avatar_url
    "#{object.avatar.icon.url}"
  end

  def team_url
    team_path(object)
  end
end
