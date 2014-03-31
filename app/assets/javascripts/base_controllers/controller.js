Gameway.Controller = Ember.Controller.extend({
  gon: Gameway.gon,
  currentUser: function() {
    if (Gameway.gon.get('currentUserPayload.user') === null) { return null; }
    this.store.push('lolAccount', Gameway.gon.get('currentUserPayload.lolAccounts.0'));
    return this.store.push('user', Gameway.gon.get('currentUserPayload.user'));
  }.property('Gameway.gon.currentUserPayload')
})
