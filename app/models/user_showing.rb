class UserShowing < ActiveRecord::Base
  belongs_to :user
  belongs_to :match, inverse_of: :user_showings
  validate :maximum_of_two_user_showings_per_match

  def maximum_of_two_user_showings_per_match
    if match.user_showings.count == 2 || match.user_showings.length > 2
      errors.add(:user_showing, "can't have more than 2 user showings")
    end
  end
end
