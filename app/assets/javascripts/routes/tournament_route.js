Gameway.TournamentRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('tournament', params.tournament_id) // default behavior
  }
});
