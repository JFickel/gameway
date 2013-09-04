class Tournament < ActiveRecord::Base
  belongs_to :owner, foreign_key: 'user_id', class_name: User
  has_many :tournament_members
  has_many :users, through: :tournament_members
end
