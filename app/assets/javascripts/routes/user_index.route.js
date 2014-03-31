Gameway.UserIndexRoute = Gameway.Route.extend({
  model: function(params) {
    return this.modelFor('user')
  }
});
