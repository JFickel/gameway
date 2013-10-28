module TournamentHelper
  def output_status(tournament)
    if tournament.open_applications == true && tournament.open_applications == false
      I18n.t('tournaments.open_applications')
    elsif tournament.open == false && tournament.open_applications == false
      I18n.t('tournaments.closed')
    elsif tournament.open == true
      I18n.t('tournaments.open')
    end
  end
end
