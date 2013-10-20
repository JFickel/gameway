class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :omniauthable, :validatable,
         :omniauth_providers => [:facebook, :twitch_oauth2], :authentication_keys => [:login]

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

  mount_uploader :avatar, AvatarUploader

  attr_accessor :login
  validates :username, presence: true

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
end
