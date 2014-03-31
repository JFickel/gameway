Gameway.ApplicationRoute = Gameway.Route.extend({
  actions: {
    openProcessingModal: function(modalName) {
      this.render('processing', {
        into: 'application',
        outlet: 'modal'
      });
    },
    closeProcessingModal: function() {
      $('.modal-backdrop').remove();
      return this.disconnectOutlet({
        outlet: 'modal',
        parentView: 'application'
      });
    }
  }
})
