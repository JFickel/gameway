Gameway.TournamentController = Ember.ObjectController.extend({
  actions: {
    destroy: function(model) {
      var thisController = this;
      model.destroyRecord().then(function() {
        thisController.transitionToRoute('tournaments.index')
      })
    }
  }
})
