class UserShowing < ActiveRecord::Base
  belongs_to :user
  belongs_to :match, inverse_of: :user_showings
  validates :user_id, presence: true
  validate :maximum_of_two_user_showings_per_match, :cannot_have_two_of_the_same_user_in_single_match,
  :cannot_advance_both_players_from_the_same_match

  def maximum_of_two_user_showings_per_match
    if match.user_showings.count == 2 || match.user_showings.length > 2
      errors.add(:user_showing, "can't have more than 2 user showings per match")
    end
  end

  def cannot_have_two_of_the_same_user_in_single_match
    if match.user_showings.where(user_id: user_id).count > 0 || match.user_showings.select {|us| us.user_id == user_id }.length > 1
      errors.add(:user_showing, "can't have more than 1 of the same user per match")
    end
  end

  def cannot_advance_both_players_from_the_same_match
    if UserShowing.where(user_id: user_id).last.match.user_showings.select {|last_us| match.user_showings.any? { |us| last_us.user_id == us.user_id }  }.length > 0
      errors.add(:user_showing, "can't have both players from the same previous match advance")
    end
  end
end
