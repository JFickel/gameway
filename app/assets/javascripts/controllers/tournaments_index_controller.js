Gameway.TournamentsIndexController = Ember.ArrayController.extend({
  sortProperties: ['id'],
  sortAscending: true,
  helloBinding: 'Gameway.gon.userSignedIn'
  // hello: function() {
    // return gon.user_signed_in
  // }.property()
})
