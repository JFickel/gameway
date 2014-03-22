Gameway.TournamentsIndexRoute = Gameway.Route.extend({
  model: function() {
    return this.store.findAll('tournament')
  }
});
