class Group < ActiveRecord::Base
  has_many :group_memberships
  has_many :users, through: :group_memberships
  has_many :events
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :affiliate_team_relationships, foreign_key: :affiliate_group_id, class_name: 'Affiliate'
  has_many :affiliates, through: :affiliate_team_relationships


  include PgSearch
  pg_search_scope :text_search,
                  against: {name: 'A', kind: 'B'},
                  using: { tsearch: { prefix: true }}
end
