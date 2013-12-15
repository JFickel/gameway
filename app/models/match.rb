class Match < ActiveRecord::Base
  # remember to delete tournament_members
  belongs_to :tournament, inverse_of: :matches
  has_many :user_showings, inverse_of: :match
  has_many :users, through: :user_showings
  has_many :team_showings
  has_many :teams, through: :team_showings

  def showings
    if tournament.mode == 'individual'
      user_showings
    elsif tournament.mode == 'team'
      team_showings
    end
  end
end
