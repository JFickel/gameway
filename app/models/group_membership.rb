class GroupMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  validates :user_id, uniqueness: { scope: :group_id,
  message: 'can only sign up for a group once'}

end
