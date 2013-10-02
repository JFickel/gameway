class Match < ActiveRecord::Base
  # remember to delete tournament_members
  belongs_to :tournament
  has_many :user_showings
  has_many :users, through: :user_showings
  has_many :team_showings
  has_many :teams, through: :team_showings
end