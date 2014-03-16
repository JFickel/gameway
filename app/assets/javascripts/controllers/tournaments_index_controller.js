Gameway.TournamentsIndexController = Ember.ArrayController.extend({
  sortProperties: ['id'],
  sortAscending: true,
  hello: function() {
    return gon.user_signed_in
  }.property()
})
