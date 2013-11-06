module TeamHelper
  def output_team_status(team)
    if team.open_applications == true
      I18n.t('tournaments.open')
    else
      I18n.t('tournaments.closed')
    end
  end
end
