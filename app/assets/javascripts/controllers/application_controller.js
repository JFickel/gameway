Gameway.ApplicationController = Gameway.Controller.extend({
  init: function() {
    if (this.get('gon.emailConfirmed')) {
      Gameway.flashController.pushObject({message: "Thanks for signing up! You can now log into your account.",
                                          type: 'alert-success'});
    }
    if (this.get('gon.twitchAuthFailure')) {
      Gameway.flashController.pushObject({message: "Failed to authenticate with Twitch.",
                                          type: 'alert-danger'});
    }
    if (this.get('gon.firstTwitchAuth')) {
      this.transitionTo('user.edit', this.get('currentUser'));
      Gameway.flashController.pushObject({message: "Successfully connected with Twitch. Your current password has been randomly generated, and a password reset link has been sent to your email in case you want to set your password.",
                                          type: 'alert-info'});
    }
    if (this.get('gon.twitchAuth')) {
      if (this.get('currentUser.lolAccount')) {
        this.transitionTo('tournaments.index');
      } else {
        this.transitionTo('user.edit', this.get('currentUser'))
      }
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
          Gameway.gon.set('currentUserPayload', data.current_user_payload);
          thisController.store.pushPayload('user', data.current_user_payload);
          Gameway.gon.set('userSignedIn', true);
          thisController.transitionTo('tournaments')
        },
        error: function(jqXHR, textStatus, errorThrown) {
          thisController.set('hasSignInError', true)
        }
      });
    },
    logout: function() {
      var thisController = this;
      $.ajax({
        type: "DELETE",
        url: "users/sign_out",
        data: { authenticity_token: Gameway.gon.get('authenticityToken') },
        success: function(data) {
          Gameway.gon.set('authenticityToken', data.authenticity_token)
          Gameway.gon.set('currentUserPayload', null);
          Gameway.gon.set('userSignedIn', false);
          thisController.transitionTo('index')
        }
      })
    }
  }
});
