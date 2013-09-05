class Tournament < ActiveRecord::Base
  belongs_to :owner, foreign_key: 'user_id', class_name: User
  has_many :tournament_members
  has_many :users, through: :tournament_members
  serialize :bracket

  def start
    rounds = Math.log2(tournament_members.count).ceil
    slots = 1
    rounds.times do |i|
      i += 1
      slots += 2**i
    end
    self.bracket = Array.new(slots)
    initialize_bracket
    self.save
  end

  def initialize_bracket
    ## Takes the number of rounds and finds how many slots are contested
    ## for the round following the "filter" round. It then takes these contested
    ## slots, multiplies them by two and shoves that amount of players into
    ## the "filter" round. The remainder get moved into the end of the next round.
    rounds = Math.log2(tournament_members.count).ceil
    after_filter_slots = 2**(rounds - 1)
    filter_slots = tournament_members.count - after_filter_slots
    initial_round_size = filter_slots * 2
    self.bracket[0..initial_round_size-1] = tournament_members.first(initial_round_size)
    skip = (2**rounds) + filter_slots
    self.bracket[skip..(after_filter_slots - filter_slots)] = tournament_members[initial_round_size..-1]
  end
end
