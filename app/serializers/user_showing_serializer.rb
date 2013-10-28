class UserShowingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :top

  self.root = false

  def username
    object.user.username
  end
end
