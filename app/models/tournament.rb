class Tournament < ActiveRecord::Base
  has_one :bracket
  belongs_to :user
  has_many :participants

  def start
  end
end
