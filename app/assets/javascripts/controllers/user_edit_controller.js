Gameway.UserEditController = Ember.Controller.extend({
  summonerName: '',
  oldPassword: '',
  newPassword: '',
  newPasswordConfirmation: '',

  hasSummonerNameError: false,
  hasOldPasswordError: false,
  hasNewPasswordError: false,
  hasNewPasswordConfirmationError: false,

  summonerNameErrors: [],
  oldPasswordErrors: [],
  newPasswordErrors: [],
  newPasswordConfirmationErrors: [],

  regions: [
    { label: 'Brazil', value: 'br' },
    { label: 'EU Nordic & East', value: 'eune' },
    { label: 'EU West',  value: 'euw' },
    { label: 'Latin America North', value: 'lan' },
    { label: 'Latin America South', value: 'las' },
    { label: 'North America', value: 'na' },
    { label: 'Oceania', value: 'oce' }
  ],

  actions: {
    addSummonerName: function() {

    },
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
              thisController.set('newPasswordConfirmationErrors', data.errors.password_confirmation);
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
