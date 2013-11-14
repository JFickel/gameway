class Tournament < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessor :start_date, :start_hour, :start_minute, :start_period

  belongs_to :owner, foreign_key: 'user_id', class_name: User
  has_many :tournament_memberships
  has_many :users, through: :tournament_memberships
  has_many :teams, through: :tournament_memberships
  has_many :matches, inverse_of: :tournament
  has_many :user_showings, through: :matches
  has_many :team_showings, through: :matches
  has_many :moderator_roles
  has_many :moderators, through: :moderator_roles, source: :user
  has_many :broadcaster_roles
  has_many :broadcasters, through: :broadcaster_roles, source: :user
  has_many :applications
  has_many :applicants, through: :applications, source: :user
  has_many :comments
  has_many :commenters, through: :comments, source: :user

  serialize :bracket

  has_many :affiliate_team_relationships, foreign_key: :affiliated_tournament_id, class_name: 'Affiliation', dependent: :destroy
  has_many :affiliates, through: :affiliate_team_relationships, source: :affiliate_team, class_name: 'Team'

  include PgSearch
  pg_search_scope :text_search,
                  against: {title: 'A', description: 'B', game: 'C'},
                  using: { tsearch: { prefix: true }}

  multisearchable against: [:title, :description],
                  using: { tsearch: { prefix: true }}

  validates :title, presence: true, length: { maximum: 38 }
  validates :game, presence: true
  validates_with TimeValidator, on: :create
  validates_with TimeValidator, on: :update, if: :time_parameters?
  before_save :set_starts_at, if: :time_parameters?

  def set_starts_at
    self.starts_at = Time.zone.parse("#{start_date} #{start_hour}:#{start_minute}#{start_period}")
  end

  def time_parameters?
    start_hour.present? || start_minute.present? || start_date.present?
  end

  def start
    reset_bracket_components
    return self if tournament_memberships.empty?
    self.bracket = Bracket.new(self).construct
    self.started = true
    self.save
  end

  def participant_count
    case self.mode
    when 'individual'
      self.users.count
    when 'team'
      self.teams.count
    end
  end

  def reset_bracket_components
    self.user_showings.each(&:destroy)
    self.team_showings.each(&:destroy)
    self.matches.destroy_all
    self.bracket = nil
  end
end
