class UserShowingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :top

  def username
    object.user.username
  end
end
