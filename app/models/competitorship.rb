class Competitorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  belongs_to :team

  validates :team_id, uniqueness: { scope: :tournament_id, message: 'can only sign up team once per tournament' }, allow_nil: true
  validates :user_id, uniqueness: { scope: :tournament_id, message: 'can only sign up user once per tournament' }, allow_nil: true
end
