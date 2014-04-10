class Tournament < ActiveRecord::Base
  has_one :bracket
  belongs_to :user
  has_many :competitorships
  has_many :users, through: :competitorships
  has_many :teams, through: :competitorships

  def start
    self.started = true
    self.started_at = Time.current
    self.bracket = Bracket.new(participants: participants)
  end

  def participants
    self.users ? self.users : self.teams
  end
end
