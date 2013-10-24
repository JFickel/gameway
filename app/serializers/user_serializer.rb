class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :full_name, :avatar_url

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def avatar_url
    "#{object.avatar.thumb.url}"
  end
end
