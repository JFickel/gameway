class UserSerializer < ApplicationSerializer
  attributes :id, :email, :avatar_url

  has_one :lol_account
  has_many :teams

  def avatar_url
    object.avatar.url || "https://s3.amazonaws.com/gameway-production/user_accounts/default_profile.png"
  end

  def teams
    object.all_teams
  end
end
