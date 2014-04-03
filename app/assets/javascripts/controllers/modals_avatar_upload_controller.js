Gameway.ModalsAvatarUploadController = Gameway.Controller.extend({
  actions: {
    cancelAvatarUpload: function() {
      this.send('closeModal')
    },
    uploadAvatar: function() {
      var file = $('#avatarUploadField')[0].files[0],
          reader = new FileReader(),
          thisController = this;

      thisController.set('currentlyUploading', true);
      thisController.set('fileExtension', file.name.match(/\..*/)[0]);

      // When finished reading the file, send AJAX request to save
      reader.onload = (function(theFile) {
        return function(e) {
          var fileData = e.target.result;
          $.ajax({
            type: 'PATCH',
            url: 'users/' + thisController.get('currentUser.id'),
            data: { authenticity_token: Gameway.gon.get('authenticityToken'),
                    file_data: fileData,
                    file_extension: thisController.get('fileExtension')
            },
            success: function(data) {
              if (data.errors) {
                thisController.set('currentlyUploading', false);
                data.errors.forEach(function(error) {
                  Gameway.flashController.pushObject({message: error,
                                                      type: 'alert-danger'})
                })
              } else {
                thisController.set('currentlyUploading', false);
                thisController.send('closeModal')
                thisController.set('currentUser.avatarUrl', data.avatar_url + '?' + Math.random())
              }
            }
          })
        }
      })(file);

      reader.readAsDataURL(file)
    }
  }
})
