class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :users, through: :team_memberships
  has_many :events
  has_many :tournament_memberships
  has_many :tournaments, through: :tournament_memberships

  has_many :affiliated_tournament_relationships,
    foreign_key: :affiliate_team_id,
    class_name: 'Affiliation',
    dependent: :destroy
  has_many :affiliated_tournaments,
    through: :affiliated_tournament_relationships,
    source: :affiliated_tournament,
    class_name: 'Tournament'

  has_many :affiliated_group_relationships,
    foreign_key: :affiliate_team_id,
    class_name: 'Affiliation',
    dependent: :destroy
  has_many :affiliated_groups,
    through: :affiliated_group_relationships,
    source: :affiliated_group,
    class_name: 'Group'

  has_many :affiliated_team_relationships,
    foreign_key: :affiliate_team_id,
    class_name: 'Affiliation',
    dependent: :destroy
  has_many :affiliated_teams,
    through: :affiliated_team_relationships,
    source: :affiliated_team,
    class_name: 'Team'

  has_many :affiliate_team_relationships,
    foreign_key: :affiliated_team_id,
    class_name: 'Affiliation',
    dependent: :destroy
  has_many :affiliates,
    through: :affiliate_team_relationships,
    source: :affiliate_team,
    class_name: 'Team'


  belongs_to :leader, foreign_key: 'user_id', class_name: User
  validates :name, presence: true, length: { minimum: 3, maximum: 24 }, uniqueness: { case_sensitive: false }

  mount_uploader :avatar, AvatarUploader

  include PgSearch
  pg_search_scope :text_search,
                  against: :name,
                  using: { tsearch: { prefix: true }}

  multisearchable against: :name,
                  using: { tsearch: { prefix: true }}

  def self.construct(options)
    team = Team.new(name: options[:name])
    team.team_memberships <<  TeamMembership.new(user_id: options[:user].id)
    team.leader = options[:user]
    return team
  end
end
