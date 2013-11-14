class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  belongs_to :team
  validates :user_id, uniqueness: {scope: [:role, :tournament_id], message: 'has already been invited'}
  before_save :set_message
  validates_with InvitationValidator


  def set_message
    sender = User.try(:find, sender_id)
    if team_id.present?
      self.message = "#{sender.username} has sent you a team invitation to join #{Team.find(team_id).name}."
    elsif tournament_id.present? && role == 'moderator'
      self.message = "#{sender.username} has invited you to moderate #{Tournament.find(tournament_id).title}"
    elsif tournament_id.present? && role == 'broadcaster'
      self.message = "#{sender.username} has invited you to broadcast #{Tournament.find(tournament_id).title}"
    end
  end
end
