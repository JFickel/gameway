Gameway.TournamentsNewController = Gameway.Controller.extend({
  name: '',
  description: '',
  actions: {
    create: function() {
      var thisController = this;
      this.store.createRecord('tournament', {
        name: this.get('name'),
        description: this.get('description'),
        user: this.get('currentUser')
      }).save().then(function (tournament) {
        thisController.transitionToRoute('tournament', tournament)
      })
    }
  }
})
