class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:twitchtv]

  has_one :lol_account
  has_many :tournaments

  def self.find_for_twitchtv_oauth(auth)
    user = where(auth.slice(:provider, :uid)).first
    return [user, false] if user.present?

    if user = User.where(email: auth.info.email).first
      user.update_attributes(provider: auth.provider, uid: auth.uid)
      return user, false
    end

    user = User.new(provider: auth.provider,
                    uid: auth.uid,
                    email: auth.info.email,
                    password: Devise.friendly_token[0,20])

    # user.name = auth.info.name   # assuming the user model has a name
    # user.image = auth.info.image # assuming the user model has an image

    user.skip_confirmation!
    user.save
    return user, true
  end
end
