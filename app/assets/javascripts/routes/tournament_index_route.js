Gameway.TournamentIndexRoute = Gameway.Route.extend({
  model: function(params) {
    return this.modelFor('tournament');
  }
});
