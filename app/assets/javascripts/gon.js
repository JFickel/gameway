Gameway.Gon = Ember.Object.extend({
  currentUser: gon.current_user,
  userSignedIn: gon.user_signed_in,
  authenticityToken: gon.authenticity_token,
  emailConfirmed: gon.email_confirmed
})

Gameway.gon = Gameway.Gon.create()
