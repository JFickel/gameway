class Team < ActiveRecord::Base
  belongs_to :leader, foreign_key: 'user_id', class_name: User
  has_many :members, through: :team_memberships, source: :user
  has_many :team_memberships
  has_many :matchups
  has_many :competitorships
  has_many :tournaments, through: :competitorships

  def all_users
    members + leader
  end
end
