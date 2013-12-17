class UserShowingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :top, :match_id

  # self.root = false

  def username
    object.user.username
  end
end
