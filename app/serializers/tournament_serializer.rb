class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :ordered_bracket, :mode

  def ordered_bracket
    tournament = Tournament.includes(:matches).find(object)
    if tournament.bracket.present?
      tournament.bracket.map do |round|
        round.map do |match|
          if match != nil
            MatchSerializer.new match
          end
        end
      end
    end
  end
end
