class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :ordered_bracket, :mode, :current_opponent, :started, :live

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

  def current_opponent
    if object.started?
      if object.current_opponent(scope).class == Team
        TeamSerializer.new object.current_opponent(scope)
      elsif object.current_opponent(scope).class == User
        UserSerializer.new object.current_opponent(scope)
      end
    end
  end
end
