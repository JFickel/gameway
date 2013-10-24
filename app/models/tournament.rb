class Tournament < ActiveRecord::Base
  belongs_to :owner, foreign_key: 'user_id', class_name: User
  has_many :tournament_memberships
  has_many :users, through: :tournament_memberships
  has_many :matches, inverse_of: :tournament
  has_many :user_showings, through: :matches
  has_many :moderator_roles
  has_many :moderators, through: :moderator_roles, source: :user
  serialize :bracket

  include PgSearch
  pg_search_scope :text_search,
                  against: {title: 'A', description: 'B'},
                  using: { tsearch: { prefix: true }}

  attr_accessor :start_date, :start_hour, :start_minute, :start_period

  validate :hour_is_in_range, :minute_is_in_range, :numeric_presence_of_hour, :numeric_presence_of_minute, :presence_of_date, on: :create
  validate :hour_is_in_range, :numeric_presence_of_hour, on: :update, if: :time_present?
  validate :minute_is_in_range, :numeric_presence_of_minute, on: :update, if: :time_present?
  validate :presence_of_date, on: :update, if: :time_present?

  before_save :set_starts_at, if: :time_present?

  def set_starts_at
    self.starts_at = DateTime.parse("#{start_date} #{start_hour}:#{start_minute}#{start_period}")
  end

  def time_present?
    start_hour.present? || start_minute.present? || start_date.present?
  end

  def presence_of_date
    unless start_date.present?
      errors.add(:tournament, 'date is not present')
    end
  end

  def hour_is_in_range
    if start_hour.to_i < 1 || start_hour.to_i > 12
      errors.add(:tournament, 'hour entered is invalid')
    end
  end

  def minute_is_in_range
    if start_minute.to_i < 0 || start_minute.to_i > 59
      errors.add(:tournament, 'minute entered is invalid')
    end
  end

  def numeric_presence_of_hour
    if !start_hour.match(/\A[+-]?\d+\Z/)
      errors.add(:tournament, 'hour is not present or is not numeric')
    end
  end

  def numeric_presence_of_minute
    if !start_hour.match(/\A[+-]?\d+\Z/)
      errors.add(:tournament, 'minute is not present or is not numeric')
    end
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

  def initialize_bracket
    ## Takes the number of rounds and finds how many slots are contested
    ## for the round following the "filter" round. It then takes these contested
    ## slots, multiplies them by two and shoves that amount of players into
    ## the "filter" round. The remainder get moved into the end of the next round.
    rounds = calculate_rounds
    filtered_round_size = calculate_filtered_round_size(rounds)
    filter_pairs = calculate_number_of_filter_pairs(filtered_round_size)
    filter_slots = filter_pairs*2

    self.bracket[0][0..((filter_slots/2)-1)] = add_filled_matches_to_filter_round(filter_slots)

    ### Refactor this:

    if tournament_memberships[filter_slots..-1].length.odd?
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
      self.bracket[1][(filter_pairs/2)..-1] = after_filter_round
    else
      self.bracket[1][(filter_pairs/2)..-1] = tournament_memberships[filter_slots..-1].each_slice(2).with_object([]) do |pair,obj|
        m = Match.new
        self.matches << m

        m.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
        obj << m
      end
    end
  end

  def advance position
    ## 10 lines
    ## Find the correct match
    match = self.bracket[position[0]][position[1]]

    ## Find the user depending on whether he's on top of the pair or not
    if position[2] == 1
      us = match.user_showings.find {|us| us.top == nil }  ## methods
      user = User.find(us.user_id)
    else
      us = match.user_showings.find {|us| us.top == true }
      user = User.find(us.user_id)
    end

    ## Create a new user showing and place him on top if his index is even
    new_showing = UserShowing.new(user: user, top: (position[1].even? ? true : nil) )

    ## Place the new user showing the correct position
    new_match = self.bracket[position[0]+1][position[1]/2]
    if new_match.nil?
      m = Match.create
      self.matches << m

      m.user_showings.push new_showing
      self.bracket[position[0]+1][position[1]/2] = m
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
      us = match.user_showings.find {|us| us.top == true }
    end

    if match.user_showings.count == 1
      us = match.user_showings.first
    end

    us.destroy
  end
end
