class Affiliation < ActiveRecord::Base
  belongs_to :affiliate_team, class_name: 'Team'
  belongs_to :affiliated_tournament, class_name: 'Tournament'
  belongs_to :affiliated_team, class_name: 'Team'
  belongs_to :affiliated_group, class_name: 'Group'
  validates :affiliate_team_id, uniqueness: { scope: :affiliated_tournament_id }
  validates :affiliate_team_id, uniqueness: { scope: :affiliated_team_id }
  validates :affiliated_team_id, uniqueness: { scope: :affiliate_team_id }
  validates :affiliate_team_id, uniqueness: { scope: :affiliated_group_id }
end
