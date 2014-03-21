Gameway.UserEditController = Ember.Controller.extend({
  oldPassword: '',
  newPassword: '',
  newPasswordConfirmation: '',

  hasOldPasswordError: false,
  hasNewPasswordError: false,
  hasNewPasswordConfirmationError: false,

  oldPasswordErrors: [],
  newPasswordErrors: [],
  newPasswordConfirmationErrors: [],

  actions: {
    updatePassword: function() {
      var thisController = this;
      $.ajax({
        type: 'PATCH',
        url: 'users/password',
        data: { authenticity_token: Gameway.gon.get('authenticityToken'),
                id: Gameway.gon.get('currentUser.id'),
                user: {
                  current_password: thisController.get('oldPassword'),
                  password: thisController.get('newPassword'),
                  password_confirmation: thisController.get('newPasswordConfirmation')
                }
              },
        success: function(data) {
          if (data.errors) {
            if (data.errors.password) {
              thisController.set('hasNewPasswordError', true);
              thisController.set('newPasswordErrors', data.errors.password);
            }
            else if (data.errors.password_confirmation) {
              thisController.set('hasNewPasswordConfirmationError', true);
              thisController.est('newPasswordConfirmationErrors', data.errors.password_confirmation);
            }
            else if (data.errors.current_password) {
              thisController.set('hasOldPasswordError', true);
              thisController.set('oldPasswordErrors', data.errors.current_password);
            }
          } else {
            Gameway.gon.set('authenticityToken', data.authenticity_token);
            Gameway.flashController.pushObject({message: "Password successfully changed.",
                                                type: 'alert-success'});
          }
        }
      })
    }
  }
})
