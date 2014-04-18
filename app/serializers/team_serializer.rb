class TeamSerializer < ApplicationSerializer
  attributes :id, :name, :lol_region, :user_id, :avatar_url, :icon_url

  has_many :matchups
  has_many :users

  def users
    object.all_users
  end

  def avatar_url
    object.avatar.url || "https://s3.amazonaws.com/gameway-production/user_accounts/default_profile.png"
  end

  def icon_url
    object.avatar.icon.url || "https://s3.amazonaws.com/gameway-production/user_accounts/default_profile.png"
  end
end
