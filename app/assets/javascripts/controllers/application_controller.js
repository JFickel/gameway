Gameway.ApplicationController = Gameway.Controller.extend({
  init: function() {
    if (this.get('gon.emailConfirmed')) {
      Gameway.flashController.pushObject({message: "Thanks for signing up! You can now log into your account.",
                                          type: 'alert-success'})
    }
    if (this.get('gon.twitchAuthFailure')) {
      Gameway.flashController.pushObject({message: "Failed to authenticate with Twitch.",
                                          type: 'alert-danger'})
    }
    if (this.get('gon.firstTwitchAuth')) {
      Gameway.flashController.pushObject({message: "Successfully connected with Twitch. Your current password has been randomly generated, and a password reset link has been sent to your email. We suggest that you change your password now.",
                                          type: 'alert-info'})
    }
  },
  twitchAuthURL: window.location.origin + '/users/auth/twitchtv',
  email: '',
  password: '',
  hasSignInError: false,
  actions: {
    sign_in: function() {
      var thisController = this;
      $.ajax({
        type: "POST",
        url: "users/sign_in",
        data: { authenticity_token: Gameway.gon.get('authenticityToken'),
                user: {
                  email: thisController.get('email'),
                  password: thisController.get('password')
                }
              },
        success: function(data) {
          thisController.set('hasSignInError', false)
          Gameway.gon.set('authenticityToken', data.authenticity_token)
          Gameway.gon.set('currentUser', data.user);
          Gameway.gon.set('userSignedIn', true);
          console.log("Signed in! :3");
        },
        error: function(jqXHR, textStatus, errorThrown) {
          thisController.set('hasSignInError', true)
        }
      });
    },
    logout: function() {
      $.ajax({
        type: "DELETE",
        url: "users/sign_out",
        data: { authenticity_token: Gameway.gon.get('authenticityToken') },
        success: function(data) {
          Gameway.gon.set('authenticityToken', data.authenticity_token)
          Gameway.gon.set('currentUser', null);
          Gameway.gon.set('userSignedIn', false);
          console.log("Signed out! :3");
        }
      })
    }
  }
});
