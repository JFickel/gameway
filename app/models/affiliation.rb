class Affiliation < ActiveRecord::Base
  belongs_to :affiliate_team
  belongs_to :affiliated_tournament
  belongs_to :affiliated_team
  belongs_to :affiliated_group
end
