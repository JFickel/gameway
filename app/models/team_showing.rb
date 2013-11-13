class TeamShowing < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
  validates :team_id, presence: true
  validate :maximum_of_two_team_showings_per_match, :cannot_have_two_of_the_same_team_in_single_match,
  :cannot_advance_two_teams_from_the_same_match

  def maximum_of_two_team_showings_per_match
    if match.try(:team_showings).try(:count) == 2 || match.try(:team_showings).try(:length).try(:>, 2)
      errors.add(:team_showing, "can't have more than 2 team showings per match")
    end
  end

  def cannot_have_two_of_the_same_team_in_single_match
    if match.try(:team_showings).try(:where, {team_id: team_id}).try(:count).try(:>, 0) || match.try(:team_showings).try(:select) {|ts| ts.try(:team_id) == team_id }.try(:length).try(:>, 1)
      errors.add(:team_showing, "can't have more than 1 of the same team per match")
    end
  end

  def cannot_advance_two_teams_from_the_same_match
    if any_last_match_ts_tids_equal_saved_ts_tids_from_current_match?
      errors.add(:team_showing, "will not allow two teams from that were in the same previous match advance")
    end
  end

  def any_last_match_ts_tids_equal_saved_ts_tids_from_current_match?
    # team_showings_from_last_match.try(:pluck, :team_id).try(:any?) { |last_match_us_uid| saved_team_showings_from_current_match.try(:map, &:team_id).try(:include?, last_match_us_uid) }
    team_showings_from_last_match.try(:pluck, :team_id).try(:any?) do |last_match_ts_tid|
      saved_team_showings_from_current_match.try(:map, &:team_id).try(:include?, last_match_ts_tid)
    end
  end

  def team_showings_from_last_match
    TeamShowing.where(team_id: team_id).try(:last).try(:match).try(:team_showings)
  end

  def saved_team_showings_from_current_match
    match.team_showings.select {|ts| !ts.new_record?}
  end
end
