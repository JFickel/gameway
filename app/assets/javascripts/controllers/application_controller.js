Gameway.ApplicationController = Gameway.Controller.extend({
  email: '',
  password: '',
  actions: {
    sign_in: function() {
      thisController = this;
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
          Gameway.gon.set('authenticityToken', data.authenticity_token)
          Gameway.gon.set('currentUser', data.user);
          Gameway.gon.set('userSignedIn', true);
          console.log("Signed in! :3");
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
