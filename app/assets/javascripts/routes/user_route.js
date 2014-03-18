Gameway.UserRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('user', params.user_id) // default behavior
  }
  // setupController: function(controller, user) {
  //   controller.set('model', user)
  // }
});
