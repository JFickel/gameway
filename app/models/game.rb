class Game < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
end
