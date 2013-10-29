class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  belongs_to :team
  validates :user_id, uniqueness: { scope: :team_id }
  validates :user_id, uniqueness: { scope: :tournament_id }
end
