class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :omniauthable, :validatable,
         :omniauth_providers => [:facebook, :twitch_oauth2], :authentication_keys => [:login]

  has_many :group_members
  has_many :groups, through: :group_members
  after_create :add_groups

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

  def self.find_for_omniauth(omniauth_response, signed_in_resource=nil)
    omniauth_info = omniauth_response.info
    user = if (omniauth_info.email.present?)
             User.find_by_email(omniauth_info.email)
           # elsif (omniauth_info.nickname.present?)
             # User.find_by_twitter_username(omniauth_info.nickname)
           end

    unless user # Create a user with a stub password.
      user = User.new(:email => omniauth_info.email,
                      :first_name => omniauth_info.first_name,
                      :username => omniauth_info.nickname)



      ### I need this to be in an after_create callback, but I need the omniauth_response. wat do?
      if omniauth_response.try(:extra).try(:raw_info).try(:education).present?
        omniauth_response.extra.raw_info.education.each do |education|
          group = Group.find_or_create_by(name: education.school.name, kind: education.type)
          if !group.group_members.where(user_id: user.id).exists?
            GroupMember.create(user_id: user.id)
          end
        end
      end
    end
    user

    # facebook
    # omniauth_response.credentials.token
    # returns access token
    # omniauth_response.extra.raw_info.education.last.school.name
    # => "University of Illinois Urbana-Champaign"
    # omniauth_response.extra.raw_info.education.last.type
    # => "College"
    # how do I find fb friends as they sign up?

  end

  def add_groups
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
