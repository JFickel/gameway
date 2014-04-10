class Bracket < ActiveRecord::Base
  default_scope { includes(:matches) }
  serialize :structure
  has_many :matches
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

    def rounds
      Math.log2(participants.count).ceil
    end

    def filtered_round_participants_count
      # Calculates number of contestants in second (filtered) round
      2**(rounds - 1)
    end

    def filter_round_participants_count
      # Calculates number of contestants in first (filter) round
      (participants.count - filtered_round_participants_count) * 2
    end

    def construct
      build_structure
      fill_filter_round
      fill_filtered_round
    end

    def build_structure
      # Each nested array represents a round. The rightmost array is for the winner
      winner = Match.create(matchups: [Matchup.create(top: true)])
      self.matches << winner
      self.structure = [[winner]]
      rounds.times do |round_index|
        round_matches = build_round_matches(round_index)
        structure.unshift round_matches
      end
      self.save
    end

    def build_round_matches(round_index)
      (2**(round_index+1)/2).times.with_object([]) do |match_index, round|
        next_match_index = match_index/2
        next_match = structure[0][next_match_index]
        next_matchup = next_match.matchups.find_by(top: next_match_index.even? ? true : nil)
        match = Match.create(next_matchup_id: next_matchup.id, matchups: Matchup.create([{top: true}, {}]) )
        self.matches << match
        round << match
      end
    end

    def fill_filter_round
      participants.first(filter_round_participants_count).each_slice(2).with_index do |pair, index|
        match = structure[0][index]
        match.matchups.push([Matchup.new({ "#{mode}_id".to_sym => pair[0].id, top: true }),
                             Matchup.new({ "#{mode}_id".to_sym => pair[1].id  })
                            ])
      end
    end

    def fill_filtered_round
      remaining_participants = participants[filter_round_participants_count..-1]
      return if remaining_participants.empty?
      filtered_round_matches = structure[1][filtered_round_participants_count/4..-1]
      filtered_round_matches.each do |match|
        if remaining_participants.present? && remaining_participants.odd?
          match.matchups.push([Matchup.new({ "#{mode}_id".to_sym => remaining_participants.shift.id })])
          next
        end
        match.matchups.push([Matchup.new({ "#{mode}_id".to_sym => remaining_participants.shift.id, top:true }),
                             Matchup.new({ "#{mode}_id".to_sym => remaining_participants.shift.id })
                            ])
      end
    end
end
