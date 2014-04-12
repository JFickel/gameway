class UserSerializer < ApplicationSerializer
  attributes :id, :name, :email, :avatar_url, :icon_url

  has_one :lol_account
  has_many :teams

  def avatar_url
    object.avatar.url || "https://s3.amazonaws.com/gameway-production/user_accounts/default_profile.png"
  end

  def icon_url
    object.avatar.icon.url || "https://s3.amazonaws.com/gameway-production/user_accounts/default_profile.png"
  end

  def teams
    object.all_teams
  end
end
