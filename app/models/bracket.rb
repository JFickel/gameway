class Bracket < ActiveRecord::Base
  has_many :matches
  belongs_to :tournament

  def initialize(mode: 'team', participants: [], game: 'lol')
    return if participants.empty?    
  end
end
