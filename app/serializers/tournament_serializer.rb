class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :ordered_bracket

  def ordered_bracket
    object.bracket.map do |round|
      round.map do |match|
        if match != nil
          match.user_showings.sort_by{|us| us.top ? 0 : 1 }.map {|us| us.user.username }
        end
      end
    end
  end
end
