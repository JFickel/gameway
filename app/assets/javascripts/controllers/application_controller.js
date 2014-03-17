Gameway.ApplicationController = Ember.Controller.extend({
  email: '',
  password: '',
  actions: {
    sign_in: function() {
      $.ajax({
        type: "POST",
        url: "users/sign_in",
        data: { authenticity_token: Gameway.gon.get('authenticityToken'), user: { email: this.get('email'), password: this.get('password') }, commit: "Sign in"  },
        success: function(data) {
          Gameway.gon.set('authenticityToken', data.authenticity_token);
          console.log("Signed in! :3");
          alert("we did it reddit xD")
        }
      });
    },
    logout: function() {
      $.ajax({
        type: "DELETE",
        url: "users/sign_out",
        success: function(data) {
          Gameway.gon.set('currentUser', null);
          Gameway.gon.set('userSignedIn', false);
          alert("we did it lebbit :DDD");
        }
      })
    }
  }
});
