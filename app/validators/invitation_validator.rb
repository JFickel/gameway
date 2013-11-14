class InvitationValidator < ActiveModel::Validator
  def validate record
    recipient_is_not_in_team record
    recipient_is_not_tournament_owner record
    recipient_is_not_broadcaster record
    recipient_is_not_moderator record
  end


  def recipient_is_not_in_team record
    if team = Team.try(:find_by, id: record.team_id)
      user = User.find(record.user_id)
      if team.users.include? user
        record.errors.add(:invitation, 'will not send to users already in the team.')
      end
    end
  end

  def recipient_is_not_tournament_owner record
    if tournament = Tournament.try(:find_by, id: record.tournament_id)
      user = User.find(record.user_id)
      if tournament.owner == user
        record.errors.add(:invitation, 'will not send to owner of the tournament.')
      end
    end
  end

  def recipient_is_not_broadcaster record
    if tournament = Tournament.try(:find_by, id: record.tournament_id)
      user = User.find(record.user_id)
      if tournament.broadcasters.include? user
        record.errors.add(:invitation, 'will not send to users who are already broadcasters of this tournament.')
      end
    end
  end

  def recipient_is_not_moderator record
    if tournament = Tournament.try(:find_by, id: record.tournament_id)
      user = User.find(record.user_id)
      if tournament.moderators.include? user
        record.errors.add(:invitation, 'will not send to users who are already moderators of this tournament.')
      end
    end
  end
end
