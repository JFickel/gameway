Gameway.TournamentsNewController = Gameway.Controller.extend({
  title: '',
  description: '',
  actions: {
    create: function() {
      var thisController = this;
      this.store.createRecord('tournament', {
        title: this.get('title'),
        description: this.get('description')
      }).save().then(function (tournament) {
        thisController.transitionToRoute('tournament', tournament)
      })
    }
  }
})
