class Tournament < ActiveRecord::Base
  belongs_to :owner, foreign_key: 'user_id', class_name: User
  has_many :tournament_memberships
  has_many :users, through: :tournament_memberships
  has_many :matches
  serialize :bracket

  def start
    rounds = Math.log2(tournament_memberships.count).ceil
    matches = [[nil]]
    rounds.times do |i|
      i += 1
      matches.unshift(Array.new((2**i)/2))
    end
    self.bracket = matches
    initialize_bracket
    self.started = true
    self.save
  end

  def initialize_bracket
    ## Takes the number of rounds and finds how many slots are contested
    ## for the round following the "filter" round. It then takes these contested
    ## slots, multiplies them by two and shoves that amount of players into
    ## the "filter" round. The remainder get moved into the end of the next round.
    rounds = Math.log2(tournament_memberships.count).ceil
    after_filter_slots = 2**(rounds - 1)
    filter_slots = tournament_memberships.count - after_filter_slots
    initial_round_size = filter_slots*2

    self.bracket[0][0..((initial_round_size/2)-1)] =  tournament_memberships.first(initial_round_size).each_slice(2).with_object([]) do |pair,obj|
                                                        m = Match.create
                                                        m.user_showings.push(UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id))
                                                        obj << m
                                                        self.matches << m
                                                      end

    self.bracket[1][(filter_slots/2)..-1] = tournament_memberships[initial_round_size..-1].each_slice(2).with_object([]) do |pair,obj|
                                              m = Match.create
                                              m.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
                                              obj << m
                                              self.matches << m
                                            end
  end

  def advance position

  end
end
