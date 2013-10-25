class UserShowing < ActiveRecord::Base
  belongs_to :user
  belongs_to :match, inverse_of: :user_showings
  validates :user_id, presence: true
  validate :maximum_of_two_user_showings_per_match, :cannot_have_two_of_the_same_user_in_single_match,
  :cannot_advance_two_players_from_the_same_match

  def maximum_of_two_user_showings_per_match
    if match.try(:user_showings).try(:count) == 2 || match.try(:user_showings).try(:length).try(:>, 2)
      errors.add(:user_showing, "can't have more than 2 user showings per match")
    end
  end

  def cannot_have_two_of_the_same_user_in_single_match
    if match.try(:user_showings).try(:where, {user_id: user_id}).try(:count).try(:>, 0) || match.try(:user_showings).try(:select) {|us| us.try(:user_id) == user_id }.try(:length).try(:>, 1)
      errors.add(:user_showing, "can't have more than 1 of the same user per match")
    end
  end

  def cannot_advance_two_players_from_the_same_match
    if any_last_match_us_uids_equal_saved_us_uids_from_current_match?
      errors.add(:user_showing, "will not allow two players from that were in the same previous match advance")
    end
  end

  def any_last_match_us_uids_equal_saved_us_uids_from_current_match?
    # user_showings_from_last_match.try(:pluck, :user_id).try(:any?) { |last_match_us_uid| saved_user_showings_from_current_match.try(:map, &:user_id).try(:include?, last_match_us_uid) }
    user_showings_from_last_match.try(:pluck, :user_id).try(:any?) do |last_match_us_uid|
      saved_user_showings_from_current_match.try(:map, &:user_id).try(:include?, last_match_us_uid)
    end
  end

  def user_showings_from_last_match
    User.try(:find_by, id: user_id).try(:matches).try(:where, tournament_id: match.try(:tournament).try(:id)).try(:last).try(:user_showings)
  end

  def saved_user_showings_from_current_match
    match.user_showings.select {|us| !us.new_record?}
  end
end
