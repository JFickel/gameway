class MatchSerializer < ActiveModel::Serializer
  attributes :id, :user_showings

  self.root = false

  def user_showings
    ordered_showings = object.user_showings.sort_by do |us|
      us.top ? 0 : 1
    end

    ordered_showings.map do |us|
      UserShowingSerializer.new us
    end
  end

  def team_showings
    ordered_showings = object.team_showings.sort_by do |ts|
      ts.top ? 0 : 1
    end

    ordered_showings.map do |us|
      TeamShowingSerializer.new ts
    end
  end
end
