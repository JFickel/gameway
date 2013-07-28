class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :omniauthable, :validatable,
         :omniauth_providers => [:facebook, :twitch_oauth2], :authentication_keys => [:login]

  attr_accessor :login
  validates :first_name, :last_name, presence: true

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_omniauth(omniauth_response, signed_in_resource=nil)
    omniauth_info = omniauth_response.info

    user = if (omniauth_info.email.present?)
             User.find_by_email(omniauth_info.email)
           # elsif (omniauth_info.nickname.present?)
             # User.find_by_twitter_username(omniauth_info.nickname)
           end

    unless user # Create a user with a stub password.
      user = User.new(
        :email => omniauth_info.email,
        :first_name => omniauth_info.first_name,
        :username => omniauth_info.nickname
    #     :twitter_username => omniauth_info.nickname
      )
    end
    user
  end

  def self.new_with_session(params, session)
    if ((omniauth_data = session["devise.omniauth_data"].info) rescue nil)
      replaced = {}
      replaced[:name] = omniauth_data.name if omniauth_data.name.present?
      replaced[:email] = omniauth_data.email if omniauth_data.email.present?
      replaced[:twitter_username] = omniauth_data.nickname if omniauth_data.nickname.present?
      params.merge!(replaced)
    end
    super
  end
end
