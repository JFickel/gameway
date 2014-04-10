class Tournament < ActiveRecord::Base
  has_one :bracket
  belongs_to :user
  has_many :competitorships
  has_many :users, through: :competitorships
  has_many :teams, through: :competitorships

  def start
    self.started = true
    bracket = Bracket.new
    bracket.build(participants: participants)
    self.bracket = bracket
    self.save
  end

  def participants
    self.users.present? ? self.users : self.teams
  end
end
