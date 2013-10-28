class TeamShowingSerializer < ActiveModel::Serializer
  attributes :id, :team_id, :team_name, :top

  self.root = false

  def team_name
    object.team.name
  end
end
