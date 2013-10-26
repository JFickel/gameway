class MatchSerializer < ActiveModel::Serializer
  attributes :id, :user_showings

  def user_showings
    ordered_showings = object.user_showings.sort_by do |us|
      us.top ? 0 : 1
    end

    ordered_showings.map do |us|
      UserShowingSerializer.new us
    end
  end
end
