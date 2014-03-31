Gameway.UserRoute = Gameway.Route.extend({
  model: function(params) {
    return this.store.find('user', params.user_id) // default behavior
  },
  actions: {
    openAvatarUploadModal: function() {
      this.render('avatarUpload', {
        into: 'application',
        outlet: 'modal'
      });
    },
    closeAvatarUploadModal: function() {
      $('.modal-backdrop').remove();
      return this.disconnectOutlet({
        outlet: 'modal',
        parentView: 'application'
      });
    }
  }
});
