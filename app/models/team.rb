class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :users, through: :team_memberships
  has_many :events
  has_many :tournament_memberships
  has_many :tournaments, through: :tournament_memberships
  has_many :team_showings
  has_many :matches, through: :team_showings
  has_many :invitations
  has_many :invited_users, through: :invitations, source: :user
  has_many :applications
  has_many :applicants, through: :applications, source: :user

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
  # before_create :set_gravatar_as_default

  include PgSearch
  pg_search_scope :text_search,
                  against: :name,
                  using: { tsearch: { prefix: true }}

  multisearchable against: :name,
                  using: { tsearch: { prefix: true }}


  def avatar_url(size)
    gravatar_id = Digest::MD5.hexdigest(self.name)
    "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=identicon&r=PG"
  end

  # def set_gravatar_as_default
  #   self.remote_avatar_url = "https://secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.name)}.png?s=400&d=identicon&r=PG"
  # end

  def members
    self.users - [self.leader]
  end

  def live_streams
    self.users.each.with_object([]) do |user, output|
      if user.twitch_account.try(:username)
        twitch = Twitch.new(user)
        output << twitch if twitch.stream_live?
      end
    end
  end

  def self.construct(options)
    team = Team.create(name: options[:name])
    team.team_memberships <<  TeamMembership.new(user_id: options[:leader].id)
    team.leader = options[:leader]
    team.save
    return team
  end

  def add_tournament_event(tournament)
    Event.create(team_id: self.id, start_hour: tournament.starts_at.strftime("%l").strip,
    start_minute: tournament.starts_at.strftime("%M"), start_period: tournament.starts_at.strftime("%p"),
    start_date: tournament.starts_at.strftime("%B %e, %Y"), title: tournament.title,
    description: "#{self.name} is competing in #{tournament.title}")
  end

  def remove_tournament_event(tournament)
    self.events.find_by(starts_at: tournament.starts_at).destroy
  end
end
