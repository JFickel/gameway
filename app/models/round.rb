class Round < ActiveRecord::Base
  belongs_to :bracket
  has_many :matches, -> { order(:index) }
end
  
