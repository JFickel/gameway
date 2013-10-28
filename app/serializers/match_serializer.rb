class MatchSerializer < ActiveModel::Serializer
  attributes :id, :user_showings, :team_showings

  self.root = false

  def user_showings
    if object.tournament.mode == "individual"
      ordered_showings = object.user_showings.sort_by do |us|
        us.top ? 0 : 1
      end

      ordered_showings.map do |us|
        UserShowingSerializer.new us
      end
    end
  end

  def team_showings
    if object.tournament.mode == "team"
      ordered_showings = object.team_showings.sort_by do |ts|
        ts.top ? 0 : 1
      end

      ordered_showings.map do |ts|
        TeamShowingSerializer.new ts
      end
    end
  end
end
