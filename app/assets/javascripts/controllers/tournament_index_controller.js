Gameway.TournamentIndexController = Gameway.ObjectController.extend({
  needs: ['application'],
  participatingTeams: function(model) {
    var participatingTeams = [],
        opponent,
        winner,
        reverseRounds = [],
        thisController = this,
        code = "",
        matchupUpdatesRef;
    if (this.get('started')) {
      matchupUpdatesRef = new Firebase('https://gameway.firebaseio.com/brackets/' +
                                       thisController.get('bracket.id') +
                                       '/matchup_updates/')

      console.log('https://gameway.firebaseio.com/brackets/' + thisController.get('bracket.id') + '/matchup_updates/')
      matchupUpdatesRef.on('child_changed', function(snapshot) {
        console.log("FIRED")
        thisController.store.pushPayload('matchup', { matchup: snapshot.val() });
      })
    }

    if (this.get('started') && this.get('currentUser')) {
      this.get('teams').forEach(function(team, index){
        if (thisController.get('currentUser.teams').contains(team) && thisController.get('bracket')) {
          reversedRounds = thisController.get('bracket.rounds.content').slice().reverse();

          // Searches through the latest rounds to find the latest matchup
          reversedRounds.every(function(round, reversedRoundIndex) {
            return round.get('matches').every(function(match) {
              var competingTeams = match.get('matchups').map(function(matchup) {
                    return matchup.get('team');
                  });
              if (competingTeams.contains(team)) {
                opponent = competingTeams.filter(function(competingTeam) {
                  if (team != competingTeam) { return true; }
                }).objectAt(0);
                password = thisController.get('generateCode')
                code = "pvpnet://lol/customgame/joinorcreate/map1/pick6/team5/specALL/" +
                       btoa('{"name":"Match ' +
                       match.get('id') +
                       '","extra":"' +
                       match.get('id') +
                       '","password":"' +
                       password +
                       '","report":"' +
                       // localhost forwarding address
                       'https:\\/\\/gameway.fwd.wf\\/matchups\\/lol_advance' +
                       '"}');
                if (reversedRoundIndex == 0) {
                  winner = true;
                }
                return false;
              } else {
                return true;
              }
            });
          });
          participatingTeams.push({ team: team, opponent: opponent, winner: winner, code: code, password: password });
        }
      })
      return participatingTeams
    }
  }.property('currentUser', 'bracket.rounds.@each.matches.@each.matchups.@each.team'),
  generateCode: function makeid() {
    var text = "";
    var possible = "abcdefghijklmnpqrstuvwxyz";

    for(var i=0; i < 5; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
  }.property(),
  actions: {
    destroy: function(model) {
      if (confirm("Are you sure you want to delete %@?".fmt(model.get('name')))) {
        var thisController = this;
        model.destroyRecord().then(function() {
          thisController.transitionToRoute('tournaments.index')
        })
      }
    },
    joinTournamentModal: function() {
      this.send('openModal', 'modals/join_tournament')
    },
    startTournament: function() {
      this.get('model').start();
      // var thisController = this,
          // matchupUpdatesRef
      // $.ajax({
      //   method: 'PATCH',
      //   url: '/tournaments/' + thisController.get('id'),
      //   data: { start: true },
      //   success: function(data) {
      //     if (data.errors) {
      //       Gameway.flashController.pushObject({message: data.errors, type: 'alert-danger'});
      //     } else {
      //       Gameway.flashController.pushObject({message: "Tournament started!", type: 'alert-info'})
      //       thisController.store.pushPayload('tournament', data);
      //       matchupUpdatesRef = new Firebase('https://gameway.firebaseio.com/' +
      //                                        thisController.get('bracket.id') +
      //                                        '/matchup_updates')
      //       matchupUpdatesRef.on('child_changed', function(snapshot) {
      //         thisController.store.pushPayload('matchup', { matchup: snapshot.val() });
      //       })
      //     }
      //   }
      // })
    },
    manualAdvance: function(matchup) {
      var nextMatchupId = matchup.get('match.nextMatchupId'),
          nextMatchup = this.store.getById('matchup', nextMatchupId);

      nextMatchup.set('team', matchup.get('team'));
      nextMatchup.save();
    },
    manualRegression: function(matchup){
      matchup.set('team', null);
      matchup.save();
    }
  }
})
