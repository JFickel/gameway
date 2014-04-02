Gameway.ModalsAvatarUploadView = Ember.View.extend({
  didInsertElement: function() {
    $('#avatarUploadModal').modal({backdrop: 'static'})
  }
})
