class Bracket < ActiveRecord::Base
  has_many :rounds, -> { order(:index) }
  belongs_to :tournament
  attr_accessor :participants

  def build(participants: [], game: 'lol')
    return if participants.empty?
    self.mode = participants.first.class.to_s.downcase
    self.game = game
    self.participants = participants.shuffle
    construct
    self.save
  end

  private

  def round_count
    Math.log2(participants.count).ceil
  end

  def filtered_round_participants_count
    # Calculates number of contestants in second (filtered) round
    2**(round_count - 1)
  end

  def filter_round_participants_count
    # Calculates number of contestants in first (filter) round
    (participants.count - filtered_round_participants_count) * 2
  end

  def construct
    build_rounds
    fill_filter_round
    fill_filtered_round
  end

  def build_rounds
    # Initial round is for the winner
    self.rounds << Round.create(index: round_count, matches: [Match.create(matchups: [Matchup.create(top: true)])])
    round_count.times do |reverse_index|
      round_index = round_count - reverse_index - 1
      round = Round.new(index: round_index)
      round.matches.push(build_matches(reverse_index))
      self.rounds << round
    end
  end

  def build_matches(reverse_index)
    (2**(reverse_index+1)/2).times.with_object([]) do |match_index, array|
      next_match_index = match_index/2
      next_match = rounds.first.matches[next_match_index]
      next_matchup = next_match.matchups.find_by(top: next_match_index.even? ? true : nil)
      match = Match.create(index: match_index, next_matchup_id: next_matchup.id,
                           matchups: Matchup.create([{top: true}, {}]) )
      array << match
    end
  end

  def fill_filter_round
    participants.first(filter_round_participants_count).each_slice(2).with_index do |pair, index|
      match = self.rounds.first.matches[index]
      match.matchups.each.with_index do |matchup, index|
        matchup.update_attributes({ "#{mode}_id".to_sym => pair[index].id, top: index == 0 ? true : nil })
      end
    end
  end

  def fill_filtered_round
    remaining_participants = participants[filter_round_participants_count..-1]
    return if remaining_participants.empty?
    filtered_round_matches = rounds[1].matches[filtered_round_participants_count/4..-1]
    filtered_round_matches.each do |match|
      if remaining_participants.present? && remaining_participants.odd?
        match.matchups.find_by(top: nil).update_attributes({ "#{mode}_id".to_sym => remaining_participants.shift.id })
        next
      end
      match.matchups.each.with_index do |matchup, index|
        matchup.update_attributes({ "#{mode}_id".to_sym => remaining_participants.shift.id, top: index == 0 ? true : nil })
      end
    end
  end
end
