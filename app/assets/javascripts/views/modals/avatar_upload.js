Gameway.ModalsAvatarUploadView = Ember.View.extend({
  didInsertElement: function() {
    $('#avatarUploadModal').modal({backdrop: 'static'});

    function handleImagePreview(evt) {
      var file = evt.target.files[0];

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          
          // Render thumbnail.
          $('#avatarUploadPreview').html(['<img class="img-thumbnail" src="', e.target.result,
                            '" title="', escape(theFile.name), '"/>'].join(''))
        };
      })(file);

      // Read in the image file as a data URL.
      reader.readAsDataURL(file);
    }

    document.getElementById('avatarUploadField').addEventListener('change', handleImagePreview, false);
  }
})
