class Match < ActiveRecord::Base
  has_many :matchups
  has_many :users, through: :matchups
  has_many :teams, through: :matchups
end
