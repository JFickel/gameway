class BracketController
  def initialize(tournament)
    @tournament = tournament
  end

  def find_bottom_participant(match)
    if match.tournament.mode == "individual"
      match.user_showings.find {|us| us.top == nil }  ## methods
    elsif match.tournament.mode == "team"
      match.team_showings.find {|ts| ts.top == nil }  ## methods
    end
  end

  def find_top_participant(match)
    if match.tournament.mode == "individual"
      match.user_showings.find {|us| us.top == true } || match.user_showings.first ## methods
    elsif match.tournament.mode == "team"
      match.team_showings.find {|ts| ts.top == true } || match.team_showings.first ## methods
    end
  end

  def create_and_position_new_match(position, new_showing)
    match = Match.create
    @tournament.matches << match
    add_showing_to_match(match, new_showing)

    @tournament.bracket[position[0]+1][position[1]/2] = match
  end

  def add_showing_to_match(match, new_showing)
    if @tournament.mode == "individual"
      match.user_showings.push new_showing
    elsif @tournament.mode == "team"
      match.team_showings.push new_showing
    end
  end

  def set_new_showing(participant, position)
    if @tournament.mode == "individual"
      UserShowing.new(user_id: participant.user_id, top: (position[1].even? ? true : nil) )
    elsif @tournament.mode == "team"
      TeamShowing.new(team_id: participant.team_id, top: (position[1].even? ? true : nil) )
    end
  end

  def advance position
    match = @tournament.bracket[position[0]][position[1]]

    if position[2] == 1
      participant = find_bottom_participant(match)
    else
      participant = find_top_participant(match)
    end

    ## Create a new user showing and place him on top if his index is even
    new_showing = set_new_showing(participant, position)

    ## Place the new user showing the correct position
    next_match = @tournament.bracket[position[0]+1][position[1]/2]
    if next_match.nil?
      create_and_position_new_match(position, new_showing)
    else
      add_showing_to_match(next_match, new_showing)
    end
    @tournament.save
  end

  def delete_slot position
    match = @tournament.bracket[position[0]][position[1]]

    if position[2] == 1
      showing = find_top_participant(match)
    else
      showing = find_top_participant(match)
    end

    showing.destroy
  end
end
