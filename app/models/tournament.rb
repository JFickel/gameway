class Tournament < ActiveRecord::Base
  has_one :bracket
  belongs_to :user

  def start
  end
end
