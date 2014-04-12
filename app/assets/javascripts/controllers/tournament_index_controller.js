Gameway.TournamentIndexController = Gameway.ObjectController.extend({
  needs: ['application'],
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
      var thisController = this;
      $.ajax({
        method: 'PATCH',
        url: '/tournaments/' + thisController.get('id'),
        data: { start: true },
        success: function(data) {
          if (data.errors) {
            Gameway.flashController.pushObject({message: data.errors, type: 'alert-danger'});
          } else {
            Gameway.flashController.pushObject({message: "Tournament started!", type: 'alert-info'})
            thisController.store.pushPayload('tournament', data);
          }
        }
      })
    }
  }
})
