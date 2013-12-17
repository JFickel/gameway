class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :omniauthable, :validatable,
         :omniauth_providers => [:facebook, :twitch_oauth2], :authentication_keys => [:login]

  has_one :starcraft2_account
  has_one :twitch_account
  has_one :lol_account

  has_many :group_memberships
  has_many :groups, through: :group_memberships

  has_many :team_leaderships, foreign_key: 'user_id', class_name: Team
  has_many :team_memberships
  has_many :teams, through: :team_memberships

  has_many :owned_tournaments, foreign_key: 'user_id', class_name: Tournament
  has_many :tournament_memberships
  has_many :tournaments, through: :tournament_memberships
  has_many :user_showings
  has_many :matches, through: :user_showings
  has_many :moderator_roles
  has_many :moderated_tournaments, through: :moderator_roles, source: :tournament
  has_many :broadcaster_roles
  has_many :broadcasted_tournaments, through: :broadcaster_roles, source: :tournament
  has_many :events
  has_many :invitations
  has_many :applications
  has_many :applied_teams, through: :applications, source: :team
  has_many :applied_tournaments, through: :applications, source: :tournament
  has_many :comments
  has_many :commented_tournaments, through: :comments, source: :tournament


  mount_uploader :avatar, AvatarUploader

  attr_accessor :login, :timezone
  validates :username, presence: true, uniqueness: { case_sensitive: true }

  include PgSearch # Call searchable on PgSearch::Document objects to retrieve the underlying model instance
  pg_search_scope :text_search,
                  against: {username: 'A', first_name: 'B', last_name: 'C'},
                  using: { tsearch: { prefix: true }}

  multisearchable against: [:username, :first_name, :last_name],
                  using: { tsearch: { prefix: true }}

  # after_create :set_gravatar_as_default

  def avatar_url(size)
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=identicon&r=PG"
  end

  # def set_gravatar_as_default
  #   self.remote_avatar_url = avatar_url(400)
  #   self.save
  # end

  def search
    if params[:query].present?
      @tournaments = Tournament.text_search(params[:query])
    else
      @tournaments = all
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.new_with_session(params, session)
    if ((omniauth_data = session["devise.omniauth_data"].info) rescue nil)
      replaced = {}
      replaced[:first_name] = omniauth_data.first_name if omniauth_data.first_name.present?
      replaced[:last_name] = omniauth_data.last_name if omniauth_data.last_name.present?
      replaced[:email] = omniauth_data.email if omniauth_data.email.present?
      replaced[:username] = omniauth_data.nickname if omniauth_data.nickname.present?
      params.merge!(replaced)
    end
    super
  end

  def all_tournaments
    (self.owned_tournaments + self.tournaments).uniq
  end

  def starcraft2_account
    super || Starcraft2Account.new
  end
end
