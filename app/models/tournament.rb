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


  def find_bottom_participant(match)
    if match.tournament.mode == "individual"
      match.user_showings.find {|us| us.top == nil }  ## methods
    elsif match.tournament.mode == "team"
      match.team_showings.find {|ts| ts.top == nil }  ## methods
    end
  end

  def find_top_participant(match)
    if match.tournament.mode == "individual"
      match.user_showings.find {|us| us.top == true } || match.user_showings.first ## methods
    elsif match.tournament.mode == "team"
      match.team_showings.find {|ts| ts.top == true } || match.team_showings.first ## methods
    end
  end

  def create_and_position_new_match(position, new_showing)
    match = Match.create
    self.matches << match
    add_showing_to_match(match, new_showing)

    self.bracket[position[0]+1][position[1]/2] = match
  end

  def add_showing_to_match(match, new_showing)
    if self.mode == "individual"
      match.user_showings.push new_showing
    elsif self.mode == "team"
      match.team_showings.push new_showing
    end
  end

  def set_new_showing(participant, position)
    if self.mode == "individual"
      UserShowing.new(user_id: participant.user_id, top: (position[1].even? ? true : nil) )
    elsif self.mode == "team"
      TeamShowing.new(team_id: participant.team_id, top: (position[1].even? ? true : nil) )
    end
  end

  def advance position
    match = self.bracket[position[0]][position[1]]

    if position[2] == 1
      participant = find_bottom_participant(match)
    else
      participant = find_top_participant(match)
    end

    ## Create a new user showing and place him on top if his index is even
    new_showing = set_new_showing(participant, position)

    ## Place the new user showing the correct position
    next_match = self.bracket[position[0]+1][position[1]/2]
    if next_match.nil?
      create_and_position_new_match(position, new_showing)
    else
      add_showing_to_match(next_match, new_showing)
    end
    self.save
  end

  def delete_slot position
    match = self.bracket[position[0]][position[1]]

    if position[2] == 1
      showing = find_top_participant(match)
    else
      showing = find_top_participant(match)
    end

    showing.destroy
  end
end
