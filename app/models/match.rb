class Match < ActiveRecord::Base
  has_many :matchups, -> { order "top DESC NULLS LAST" }
  has_many :users, through: :matchups
  has_many :teams, through: :matchups

  belongs_to :round
end
