class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :full_name, :avatar_url, :user_url, :lol_account, :sc2_account

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def avatar_url
    "#{object.avatar.icon.url}"
  end

  def user_url
    user_path(object)
  end

  def lol_account
    object.lol_account
  end

  def sc2_account
    object.sc2_account
  end
end
