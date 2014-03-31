Gameway.ArrayController = Ember.ArrayController.extend({
  gon: Gameway.gon,
  currentUser: function() {
    if (Gameway.gon.get('currentUserPayload.user') === null) { return null; }
    if (Gameway.gon.get('currentUserPayload.lolAccounts.0') !== undefined) {
      this.store.push('lolAccount', Gameway.gon.get('currentUserPayload.lolAccounts.0'));
    }
    return this.store.push('user', Gameway.gon.get('currentUserPayload.user'));
  }.property('Gameway.gon.currentUserPayload')
})
