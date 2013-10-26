class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :users, through: :team_memberships
  has_many :events

  belongs_to :leader, foreign_key: 'user_id', class_name: User
  validates :name, presence: true, length: { minimum: 3, maximum: 24 }, uniqueness: { case_sensitive: false }

  mount_uploader :avatar, AvatarUploader

  include PgSearch
  pg_search_scope :text_search,
                  against: :name,
                  using: { tsearch: { prefix: true }}

  def self.construct(options)
    team = Team.new(name: options[:name])
    team.team_memberships <<  TeamMembership.new(user_id: options[:user].id)
    team.leader = options[:user]
    return team
  end
end
