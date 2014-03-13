Gameway.TournamentsIndexRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('tournament')
  }
});
