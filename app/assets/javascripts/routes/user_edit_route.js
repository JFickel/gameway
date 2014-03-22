Gameway.UserEditRoute = Gameway.Route.extend({
  beforeModel: function(transition) {
    debugger;
    if (transition.params.user.user_id !== this.get('currentUser.id')) {
      this.transitionTo('index')
    }
  }
})
