Gameway.TournamentController = Ember.ObjectController.extend({
  actions: {
    destroy: function(model) {
      if (confirm("Are you sure you want to delete %@?".fmt(model.get('title')))) {
        var thisController = this;
        model.destroyRecord().then(function() {
          thisController.transitionToRoute('tournaments.index')
        })
      }
    }
  }
})
