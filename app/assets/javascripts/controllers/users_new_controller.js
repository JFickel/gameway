Gameway.UsersNewController = Gameway.Controller.extend({
  email: '',
  password: '',
  passwordConfirmation: '',
  actions: {
    sign_up: function() {
      thisController = this;
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
          Gameway.gon.set('authenticityToken', data.authenticity_token)
          Gameway.gon.set('currentUser', data.user);
          Gameway.gon.set('userSignedIn', true);
          thisController.transitionToRoute('tournaments')
        }
      });
    }
  }
})
