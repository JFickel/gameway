class Game < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  include PgSearch
  pg_search_scope :text_search,
                  against: {name: 'A'},
                  using: { tsearch: { prefix: true }}

end
