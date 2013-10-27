class TeamShowingSerializer < ActiveModel::Serializer
  attributes :id, :team_id, :team_name, :top

  def teamname
    object.team.name
  end
end
