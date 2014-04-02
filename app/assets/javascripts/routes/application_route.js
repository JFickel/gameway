Gameway.ApplicationRoute = Gameway.Route.extend({
  actions: {
    openModal: function(modalName) {
      this.render(modalName, {
        into: 'application',
        outlet: 'modal'
      });
    },
    closeModal: function() {
      $('.modal-backdrop').remove();
      return this.disconnectOutlet({
        outlet: 'modal',
        parentView: 'application'
      });
    }
  }
})
