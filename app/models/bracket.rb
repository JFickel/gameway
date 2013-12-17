class Bracket
  attr_accessor :tournament, :tournament_memberships, :output
  def initialize(tournament)
    @tournament = tournament
    @tournament_memberships = tournament.tournament_memberships
  end

  def rounds
    Math.log2(tournament_memberships.count).ceil
  end

  def construct
    # Builds round arrays. Fills first (filter) and second (filitered) rounds with matches and showings
    construct_round_arrays
    fill_round_arrays
    return @output
  end

  private

  def construct_round_arrays
    # Each created nested array represents a round. The rightmost array represents the location for the winner
    winner_holder = Match.new
    @output = [[winner_holder]]
    tournament.matches << winner_holder
    rounds.times do |i|
      round_matches = (2**(i+1)/2).times.with_object([]) do |num,array|
        match = Match.new
        array << match
        tournament.matches << match
      end
      @output.unshift round_matches
    end
  end

  def filter_slots
    # Calculates number of contestants in first (filter) round
    (tournament_memberships.count - filtered_round_size)*2
  end

  def fill_round_arrays
    fill_filter_round_matches
    if tournament_memberships[filter_slots..-1].length.odd?
      @output[1][(filter_slots/4)..-1] = fill_filtered_round_matches_with_odd_remainder
    else
      @output[1][(filter_slots/4)..-1] = fill_filtered_round_matches_with_even_remainder
    end
  end

  def fill_filter_round_matches
    tournament_memberships.first(filter_slots).each_slice(2).with_index do |pair,index|
      match = @output[0][index]
      add_participant_pair_to_match(match, pair)
    end
  end

  def filtered_round_size
    # Calculates number of contestants in second (filtered) round
    2**(rounds - 1)
  end

  def fill_filtered_round_matches_with_odd_remainder
    @output[1][(filter_slots/4)..-1].each.with_index do |match, index|
      if index == 0
        add_first_initialized_filtered_round_participant_to_match(match)
      else
        pair = tournament_memberships[filter_slots+1..-1][index*2..(index*2)+1]
        add_participant_pair_to_match(match, pair)
      end
    end
  end

  def add_first_initialized_filtered_round_participant_to_match(match)
    if tournament.mode == 'individual'
      match.user_showings.push UserShowing.new(user_id: tournament_memberships[filter_slots..-1].first.user_id)
    elsif tournament.mode == 'team'
      match.team_showings.push TeamShowing.new(team_id: tournament_memberships[filter_slots..-1].first.team_id)
    end
  end

  def add_participant_pair_to_match(match, pair)
    if tournament.mode == 'individual'
      match.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
    elsif tournament.mode == 'team'
      match.team_showings.push TeamShowing.new(team_id: pair[0].team_id, top: true), TeamShowing.new(team_id: pair[1].team_id)
    end
  end

  def fill_filtered_round_matches_with_even_remainder
    @output[1][(filter_slots/4)..-1].each.with_index do |match, index|
      pair = tournament_memberships[filter_slots..-1][index*2..(index*2)+1]
      add_participant_pair_to_match(match, pair)
    end
  end
end
