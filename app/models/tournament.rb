class Tournament < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessor :start_date, :start_hour, :start_minute, :start_period

  belongs_to :owner, foreign_key: 'user_id', class_name: User
  has_many :tournament_memberships
  has_many :users, through: :tournament_memberships
  has_many :matches, inverse_of: :tournament
  has_many :user_showings, through: :matches
  has_many :moderator_roles
  has_many :moderators, through: :moderator_roles, source: :user
  serialize :bracket

  has_many :affiliate_team_relationships, foreign_key: :affiliated_tournament_id, class_name: 'Affiliation', dependent: :destroy
  has_many :affiliates, through: :affiliate_team_relationships, source: :affiliate_team, class_name: 'Team'

  # mode: individual, team
  # invite capability always turned on (derp)
  # open/closed: boolean
  # application_status: boolean
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

  def set_starts_at
    self.starts_at = Time.zone.parse("#{start_date} #{start_hour}:#{start_minute}#{start_period}")
  end

  def time_parameters?
    start_hour.present? || start_minute.present? || start_date.present?
  end

  def start
    reset_bracket
    rounds = calculate_rounds
    self.bracket = [[nil]]
    rounds.times do |i|
      self.bracket.unshift(Array.new((2**(i+1))/2))
    end
    initialize_bracket
    self.started = true
    self.save
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

  def add_filled_matches_to_filter_round(filter_slots)
    tournament_memberships.first(filter_slots).each_slice(2).with_object([]) do |pair,obj|
      m = Match.new
      self.matches << m

      m.user_showings.push(UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id))
      obj << m
    end
  end

  def build_filtered_round_matches_with_odd_remainder(filter_slots)
    after_filter_round = []
    m = Match.new
    self.matches << m
    m.user_showings.push UserShowing.new(user_id: tournament_memberships[filter_slots..-1].first.user_id)
    after_filter_round << m

    tournament_memberships[filter_slots+1..-1].each_slice(2) do |pair|
      m = Match.new
      self.matches << m
      m.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
      after_filter_round << m
    end
    return after_filter_round
  end

  def build_filtered_round_matches_with_even_remainder(filter_slots)
    tournament_memberships[filter_slots..-1].each_slice(2).with_object([]) do |pair, after_filter_round|
      m = Match.new
      self.matches << m

      m.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
      after_filter_round << m
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

  def find_bottom_user(match)
    us = match.user_showings.find {|us| us.top == nil }  ## methods
    User.find(us.user_id)
  end

  def find_top_user(match)
    us = match.user_showings.find {|us| us.top == true }
    User.find(us.user_id)
  end

  def create_new_match_and_position_user(position, new_showing)
    m = Match.create
    self.matches << m

    m.user_showings.push new_showing
    self.bracket[position[0]+1][position[1]/2] = m
  end

  def advance position
    match = self.bracket[position[0]][position[1]]

    if position[2] == 1
      user = find_bottom_user(match)
    else
      user = find_top_user(match)
    end

    ## Create a new user showing and place him on top if his index is even
    new_showing = UserShowing.new(user: user, top: (position[1].even? ? true : nil) )

    ## Place the new user showing the correct position
    new_match = self.bracket[position[0]+1][position[1]/2]
    if new_match.nil?
      create_new_match_and_position_user(position, new_showing)
    else
      new_match.user_showings.push new_showing
    end
    self.save
  end

  def delete_slot position
    match = self.bracket[position[0]][position[1]]

    if position[2] == 1
      us = match.user_showings.find {|us| us.top == nil }
    else
      us = match.user_showings.find {|us| us.top == true } || match.user_showings.first
    end

    us.destroy
  end
end
