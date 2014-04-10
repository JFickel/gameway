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
    }
  }
})
