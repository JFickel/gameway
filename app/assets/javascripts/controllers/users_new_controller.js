Gameway.UsersNewController = Gameway.Controller.extend({
  email: '',
  password: '',
  passwordConfirmation: '',

  hasEmailError: false,
  hasPasswordError: false,
  hasPasswordConfirmationError: false,

  emailErrors: [],
  passwordErrors: [],
  passwordConfirmationErrors: [],

  actions: {
    signUp: function() {
      var thisController = this;
      this.send('openModal', 'modals/processing');
      $.ajax({
        type: "POST",
        url: "users",
        data: { authenticity_token: Gameway.gon.get('authenticityToken'),
                user: {
                  email: thisController.get('email'),
                  password: thisController.get('password'),
                  password_confirmation: thisController.get('passwordConfirmation')
                }
              },
        success: function(data) {
          thisController.send('closeModal');
          if (data.errors) {
            if (data.errors.email) {
              thisController.set('hasEmailError', true);
              thisController.set('emailErrors', data.errors.email);
            }
            else if (data.errors.password) {
              thisController.set('hasPasswordError', true);
              thisController.set('passwordErrors', data.errors.password);
            }
            else if (data.errors.password_confirmation) {
              thisController.set('hasPasswordConfirmationError', true)
              thisController.set('passwordConfirmationErrors', data.errors.password_confirmation);
            }
          } else {
            Gameway.gon.set('authenticityToken', data.authenticity_token)
            Gameway.flashController.pushObject({message: "You're almost there! Please log into your email and click the validation link that has been sent to you.",
                                                type: 'alert-info'})
            thisController.transitionToRoute('application')
          }
        }
      });
    }
  }
})
