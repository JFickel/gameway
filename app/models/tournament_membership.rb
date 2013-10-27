class TournamentMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  belongs_to :team
  validates :user_id, uniqueness: { scope: :tournament_id,
    message: 'can only sign up once per tournament'}, if: :individual_mode
  validates :team_id, uniqueness: { scope: :tournament_id,
    message: 'can only sign up once per tournament'}, if: :team_mode

  def individual_mode
    self.tournament.try(:mode) == 'individual'
  end

  def team_mode
    self.tournament.try(:mode) == 'team'
  end
end
