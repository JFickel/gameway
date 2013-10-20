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

    if tournament_memberships[initial_round_size..-1].length.odd?
      after_filter_round = []
      m = Match.create
      m.user_showings.push UserShowing.new(user_id: tournament_memberships[initial_round_size..-1].first.user_id)
      after_filter_round << m
      self.matches << m

      tournament_memberships[initial_round_size+1..-1].each_slice(2) do |pair|
        m = Match.create
        m.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
        after_filter_round << m
        self.matches << m
      end
      self.bracket[1][(filter_slots/2)..-1] = after_filter_round
    else
      self.bracket[1][(filter_slots/2)..-1] = tournament_memberships[initial_round_size..-1].each_slice(2).with_object([]) do |pair,obj|
        m = Match.create
        m.user_showings.push UserShowing.new(user_id: pair[0].user_id, top: true), UserShowing.new(user_id: pair[1].user_id)
        obj << m
        self.matches << m
      end
    end
  end

  def advance position
    ## Find the correct match
    match = self.bracket[position[0]][position[1]]

    ## Find the user depending on whether he's on top of the pair or not
    if position[2] == 1
      us = match.user_showings.find {|us| us.top == nil }
      user = User.find(us.user_id)
    else
      us = match.user_showings.find {|us| us.top == true }
      user = User.find(us.user_id)
    end

    ## Create a new user showing and place him on top if his index is even
    if position[1].even?
      new_showing = UserShowing.new(user: user, top: true)
    else
      new_showing = UserShowing.new(user: user)
    end

    ## Place the new user showing the correct position
    new_match = self.bracket[position[0]+1][position[1]/2]
    if new_match.nil?
      m = Match.create
      m.user_showings.push new_showing
      self.bracket[position[0]+1][position[1]/2] = m
      self.matches << m
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
