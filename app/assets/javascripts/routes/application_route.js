Gameway.ApplicationRoute = Ember.Route.extend({
  actions: {
    openModal: function(modalName) {
      this.render('processing', {
        into: 'application',
        outlet: 'modal'
      });
    },
    closeModal: function() {
      debugger;
      $('.modal-backdrop').remove();
      return this.disconnectOutlet({
        outlet: 'modal',
        parentView: 'application'
      });
    }
  }
})
