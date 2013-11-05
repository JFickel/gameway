module ApplicationHelper
  def determine_tournament_roles(user, tournament)
    output = {}
    if user == tournament.owner && user.tournaments.include?(tournament)
      output[:participant] = true
    elsif user == tournament.owner
      output[:participant] = false
    end

    if user.broadcasted_tournaments.include? tournament
      output[:broadcaster] = true
    elsif !user.broadcasted_tournaments.include? tournament
      output[:broadcaster] = false
    end

    if user.moderated_tournaments.include? tournament
      output[:moderator] = true
    elsif !user.moderated_tournaments.include? tournament
      output[:moderator] = false
    end

    output[:tournament] = tournament
    output
  end

  def determine_team_roles(user, team)
    output = {}
    if current_user == team.leader
      output[:leader] = true
    else
      output[:leader] = false
    end
    output[:team] = team
    output
  end
end
