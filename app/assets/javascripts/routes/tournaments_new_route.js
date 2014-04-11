Gameway.TournamentsNewRoute = Gameway.Route.extend({
  beforeModel: function(transition) {
    if (!this.get('currentUser')) {
      this.transitionTo('users.new')
    }
  }
})
