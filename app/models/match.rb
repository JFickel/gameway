class Match < ActiveRecord::Base
  has_many :match_ups
  has_many :users, through: :match_ups
  has_many :teams, through: :match_ups
end
