Gameway.TeamsIndexRoute = Gameway.Route.extend({
  model: function() {
    return this.store.findAll('team')
  }
});
