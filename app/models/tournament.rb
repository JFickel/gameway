class Tournament < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessor :start_date, :start_hour, :start_minute, :start_period

  belongs_to :owner, foreign_key: 'user_id', class_name: User
  has_many :tournament_memberships
  has_many :users, through: :tournament_memberships
  has_many :teams, through: :tournament_memberships
  has_many :matches, inverse_of: :tournament
  has_many :user_showings, through: :matches
  has_many :team_showings, through: :matches
  has_many :moderator_roles
  has_many :moderators, through: :moderator_roles, source: :user
  has_many :broadcaster_roles
  has_many :broadcasters, through: :broadcaster_roles, source: :user
  has_many :applications
  has_many :applicants, through: :applications, source: :user

  serialize :bracket

  has_many :affiliate_team_relationships, foreign_key: :affiliated_tournament_id, class_name: 'Affiliation', dependent: :destroy
  has_many :affiliates, through: :affiliate_team_relationships, source: :affiliate_team, class_name: 'Team'

  include PgSearch
  pg_search_scope :text_search,
                  against: {title: 'A', description: 'B'},
                  using: { tsearch: { prefix: true }}

  multisearchable against: [:title, :description],
                  using: { tsearch: { prefix: true }}

  validates :title, presence: true
  validates :game, presence: true
  validates_with TimeValidator, on: :create
  validates_with TimeValidator, on: :update, if: :time_parameters?
  before_save :set_starts_at, if: :time_parameters?

  # def open_bracket
  #   Bracket.new(bracket, self)
  # end

  def set_starts_at
    self.starts_at = Time.zone.parse("#{start_date} #{start_hour}:#{start_minute}#{start_period}")
  end

  def time_parameters?
    start_hour.present? || start_minute.present? || start_date.present?
  end

  def start
    reset_bracket
    return self if tournament_memberships.empty?
    rounds = calculate_rounds
    self.bracket = [[nil]]
    rounds.times do |i|
      self.bracket.unshift(Array.new((2**(i+1))/2))
    end
    initialize_bracket
    self.started = true
    self.save
    return self
  end

  def reset_bracket
    self.user_showings.each(&:destroy)
    self.matches.destroy_all
    self.bracket = nil
  end

  def calculate_rounds
    Math.log2(tournament_memberships.count).ceil
  end

  def calculate_filtered_round_size(rounds)
    2**(rounds - 1)
  end

  def calculate_number_of_filter_pairs(filtered_round_size)
    tournament_memberships.count - filtered_round_size
  end

  def add_participant_pair_to_match(match, pair)
    if self.mode == 'individual'
      match.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
    elsif self.mode == 'team'
      match.team_showings.push TeamShowing.new(team_id: pair[0].team_id, top: true), TeamShowing.new(team_id: pair[1].team_id)
    end
  end

  def add_first_initialized_filtered_round_participant_to_match(match, filter_slots)
    if self.mode == 'individual'
      match.user_showings.push UserShowing.new(user_id: tournament_memberships[filter_slots..-1].first.user_id)
    elsif self.mode == 'team'
      match.team_showings.push TeamShowing.new(team_id: tournament_memberships[filter_slots..-1].first.team_id)
    end
  end

  def add_filled_matches_to_filter_round(filter_slots)
    tournament_memberships.first(filter_slots).each_slice(2).with_object([]) do |pair,obj|
      match = Match.new
      self.matches << match
      add_participant_pair_to_match(match, pair)
      obj << match
    end
  end

  def build_filtered_round_matches_with_odd_remainder(filter_slots)
    after_filter_round = []
    match = Match.new
    self.matches << match
    add_first_initialized_filtered_round_participant_to_match(match, filter_slots)
    after_filter_round << match

    tournament_memberships[filter_slots+1..-1].each_slice(2) do |pair|
      match = Match.new
      self.matches << match
      add_participant_pair_to_match(match, pair)
      after_filter_round << match
    end
    return after_filter_round
  end

  def build_filtered_round_matches_with_even_remainder(filter_slots)
    tournament_memberships[filter_slots..-1].each_slice(2).with_object([]) do |pair, after_filter_round|
      match = Match.new
      self.matches << match
      add_participant_pair_to_match(match, pair)
      after_filter_round << match
    end
  end

  def initialize_bracket
    ## Takes the number of rounds and finds how many slots are contested
    ## for the round following the "filter" round. It then takes these contested
    ## slots, multiplies them by two and shoves that amount of players into
    ## the "filter" round. The remainder get moved onto the end of the next round.
    rounds = calculate_rounds
    filtered_round_size = calculate_filtered_round_size(rounds)
    filter_pairs = calculate_number_of_filter_pairs(filtered_round_size)
    filter_slots = filter_pairs*2

    self.bracket[0][0..((filter_slots/2)-1)] = add_filled_matches_to_filter_round(filter_slots)

    if tournament_memberships[filter_slots..-1].length.odd?
      self.bracket[1][(filter_pairs/2)..-1] = build_filtered_round_matches_with_odd_remainder(filter_slots)
    else
      self.bracket[1][(filter_pairs/2)..-1] = build_filtered_round_matches_with_even_remainder(filter_slots)
    end
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
    self.matches << match
    add_showing_to_match(match, new_showing)

    self.bracket[position[0]+1][position[1]/2] = match
  end

  def add_showing_to_match(match, new_showing)
    if self.mode == "individual"
      match.user_showings.push new_showing
    elsif self.mode == "team"
      match.team_showings.push new_showing
    end
  end

  def set_new_showing(participant, position)
    if self.mode == "individual"
      UserShowing.new(user_id: participant.user_id, top: (position[1].even? ? true : nil) )
    elsif self.mode == "team"
      TeamShowing.new(team_id: participant.team_id, top: (position[1].even? ? true : nil) )
    end
  end

  def advance position
    match = self.bracket[position[0]][position[1]]

    if position[2] == 1
      participant = find_bottom_participant(match)
    else
      participant = find_top_participant(match)
    end

    ## Create a new user showing and place him on top if his index is even
    new_showing = set_new_showing(participant, position)

    ## Place the new user showing the correct position
    next_match = self.bracket[position[0]+1][position[1]/2]
    if next_match.nil?
      create_and_position_new_match(position, new_showing)
    else
      add_showing_to_match(next_match, new_showing)
    end
    self.save
  end

  def delete_slot position
    match = self.bracket[position[0]][position[1]]

    if position[2] == 1
      showing = find_top_participant(match)
    else
      showing = find_top_participant(match)
    end

    showing.destroy
  end
end
