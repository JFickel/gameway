Gameway.TournamentIndexController = Gameway.ObjectController.extend({
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
            Gameway.flashController.pushObject({message: data.errors, type: 'alert-danger'})
            Gameway.__container__.lookup('route:' + thisController.get('currentRouteName')).refresh();
          } else {
            Gameway.flashController.pushObject({message: "Tournament started!", type: 'alert-info'})
            Gameway.__container__.lookup('route:' + thisController.get('currentRouteName')).refresh();
          }
        }
      })
    }
  }
})
