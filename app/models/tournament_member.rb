class TournamentMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  validates :user_id, uniqueness: { scope: :tournament_id,
    message: 'can only sign up once per tournament'}
end
