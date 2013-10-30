class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
  belongs_to :team
  validates :user_id, uniqueness: { scope: :team_id }
  validates :user_id, uniqueness: { scope: :tournament_id }
  validate :user_is_not_in_team, :user_is_not_tournament_owner, :user_is_not_broadcaster_already, :user_is_not_moderator_already
  before_save :set_message

  attr_accessor :role, :sender_id

  def set_message
    sender = User.try(:find, :sender_id)
    if team_id.present?
      message ="#{sender.username} has sent you a team invitation to join #{Team.find(team_id).name}."
    elsif tournament_id.present? && role == 'moderator'
      "#{sender.username} has invited you to moderate #{Tournament.find(tournament_id).title}"
    elsif tournament_id.present? && role == 'broadcaster'
      "#{sender.username} has invited you to broadcast #{Tournament.find(tournament_id).title}"
    end
  end

  def user_is_not_in_team
    if team = Team.try(:find_by, id: team_id)
      user = User.find(user_id)
      if team.users.include? user
        errors.add(:invitation, 'will not send to users already in the team.')
      end
    end
  end

  def user_is_not_tournament_owner
    if tournament = Tournament.try(:find_by, id: tournament_id)
      user = User.find(user_id)
      if tournament.users.include? user || tournament.owner == user
        errors.add(:invitation, 'will not send to owner of the tournament.')
      end
    end
  end

  def user_is_not_broadcaster_already
    if tournament = Tournament.try(:find_by, id: tournament_id)
      user = User.find(user_id)
      if tournament.broadcasters.include? user
        errors.add(:invitation, 'will not send to users who are already broadcasters of this tournament.')
      end
    end
  end

  def user_is_not_moderator_already
    if tournament = Tournament.try(:find_by, id: tournament_id)
      user = User.find(user_id)
      if tournament.moderators.include? user
        errors.add(:invitation, 'will not send to users who are already moderators of this tournament.')
      end
    end
  end
end
