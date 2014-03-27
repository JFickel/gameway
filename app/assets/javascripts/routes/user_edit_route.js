Gameway.UserEditRoute = Gameway.Route.extend({
  beforeModel: function(transition) {
    if (transition.params.user.user_id !== this.get('currentUser.id')) {
      this.transitionTo('index')
    }
  }
})
