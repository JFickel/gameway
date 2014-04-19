Gameway.TeamsShowRoute = Gameway.Route.extend({
  model: function() {
    return this.get('currentUser.teams')
  }
});
