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
    fill_round_arrays(filter_slots)
    return @output
  end

  private

  def fill_round_arrays(filter_slots)
    @output[0][0..((filter_slots/2)-1)] = add_filled_matches_to_filter_round(filter_slots)

    if tournament_memberships[filter_slots..-1].length.odd?
      @output[1][(filter_slots/4)..-1] = build_filtered_round_matches_with_odd_remainder(filter_slots)
    else
      @output[1][(filter_slots/4)..-1] = build_filtered_round_matches_with_even_remainder(filter_slots)
    end
  end

  def filtered_round_size
    # Calculates number of contestants in second (filtered) round
    2**(rounds - 1)
  end

  def filter_slots
    # Calculates number of contestants in first (filter) round
    (tournament_memberships.count - filtered_round_size)*2
  end

  def add_participant_pair_to_match(match, pair)
    if tournament.mode == 'individual'
      match.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
    elsif tournament.mode == 'team'
      match.team_showings.push TeamShowing.new(team_id: pair[0].team_id, top: true), TeamShowing.new(team_id: pair[1].team_id)
    end
  end

  def add_first_initialized_filtered_round_participant_to_match(match, filter_slots)
    if tournament.mode == 'individual'
      match.user_showings.push UserShowing.new(user_id: tournament_memberships[filter_slots..-1].first.user_id)
    elsif tournament.mode == 'team'
      match.team_showings.push TeamShowing.new(team_id: tournament_memberships[filter_slots..-1].first.team_id)
    end
  end

  def add_filled_matches_to_filter_round(filter_slots)
    tournament_memberships.first(filter_slots).each_slice(2).with_object([]) do |pair,obj|
      match = Match.new
      tournament.matches << match
      add_participant_pair_to_match(match, pair)
      obj << match
    end
  end

  def build_filtered_round_matches_with_odd_remainder(filter_slots)
    after_filter_round = []
    match = Match.new
    tournament.matches << match
    add_first_initialized_filtered_round_participant_to_match(match, filter_slots)
    after_filter_round << match

    tournament_memberships[filter_slots+1..-1].each_slice(2) do |pair|
      match = Match.new
      tournament.matches << match
      add_participant_pair_to_match(match, pair)
      after_filter_round << match
    end
    return after_filter_round
  end

  def build_filtered_round_matches_with_even_remainder(filter_slots)
    tournament_memberships[filter_slots..-1].each_slice(2).with_object([]) do |pair, after_filter_round|
      match = Match.new
      tournament.matches << match
      add_participant_pair_to_match(match, pair)
      after_filter_round << match
    end
  end

  def construct_round_arrays
    # Each created nested array represents a round. The rightmost array represents the location for the winner
    # The nil values in these subsequent arrays (rounds) represent future match locations
    @output = [[nil]]
    rounds.times do |i|
      @output.unshift Array.new((2**(i+1))/2)
    end
  end
end
