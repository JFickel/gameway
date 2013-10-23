class UserShowing < ActiveRecord::Base
  belongs_to :user
  belongs_to :match, inverse_of: :user_showings
  validates :user_id, presence: true
  validate :maximum_of_two_user_showings_per_match, :cannot_have_two_of_the_same_user_in_single_match,
  :cannot_advance_both_players_from_the_same_match

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

  def cannot_advance_both_players_from_the_same_match
    if !UserShowing.where(user_id: user_id).last.try(:match).try(:user_showings).try(:select) {|last_us| match.try(:user_showings).try(:any?) { |us| last_us.user_id == us.user_id }  }.try(:length).try(:>, 0)
      errors.add(:user_showing, "can't have both players from the same previous match advance")
    end
  end
end
