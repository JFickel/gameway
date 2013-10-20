class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :users, through: :team_memberships
  belongs_to :leader, foreign_key: 'user_id', class_name: User
  validates :name, presence: true, length: { minimum: 3, maximum: 24 }, uniqueness: true

  mount_uploader :avatar, AvatarUploader
end
