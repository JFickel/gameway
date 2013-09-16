class TeamShowing < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
end
