class MatchUp < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  belongs_to :match
end
