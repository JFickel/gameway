Gameway.ModalsJoinTournamentController = Gameway.Controller.extend({
  needs: ['application', 'tournament'],
  teams: function() {
    var teams;
    teams = this.get('currentUser.teams').map(function(team) {
      return { label: team.get('name'), value: team.get('id')}
    })
    return teams
  }.property(),
  actions: {
    cancelJoinTournament: function() {
      this.send('closeModal')
    },
    submitTeam: function() {
      thisController = this;
      $.ajax({
        method: 'POST',
        url: '/competitorships',
        data: { competitorships: {
                  team_id: thisController.get('selectedTeam'),
                  tournament_id: thisController.get('controllers.tournament.content.id')
                }
              },
        success: function(data) {
          var teamName;
          thisController.send('closeModal')
          if (data.errors) {
            // handle errors for tournament signup i.e. team already signed up etc.
          } else {
            // handle pushing participant data? maybe refresh the models? xD
            selectedTeamName = thisController.get('teams').find(function(team) { return team.value === thisController.get('selectedTeam') }).label
            Gameway.flashController.pushObject({message: "Successfully signed up " + selectedTeamName + " for the following tournament: " + thisController.get('controllers.tournament.content.name'),
                                                type: 'alert-info'})
          }
        }
      })
    }
  }
})
