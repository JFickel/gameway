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
    sign_up: function() {
      var thisController = this;
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
            debugger;
            Gameway.gon.set('authenticityToken', data.authenticity_token)
            // Gameway.gon.set('currentUser', data.user);
            // Gameway.gon.set('userSignedIn', true);
            // need to display message that they should check their email for confirmation :3
            thisController.transitionToRoute('tournaments')
          }
        }
      });
    }
  }
})
