Gameway.UserRoute = Gameway.Route.extend({
  model: function(params) {
    return this.store.find('user', params.user_id) // default behavior
  }
});
