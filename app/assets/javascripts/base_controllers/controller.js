Gameway.Controller = Ember.Controller.extend({
  gon: Gameway.gon,
  currentUser: function() {
    if (Gameway.gon.get('currentUser') === null) { return null; }
    return this.store.push('user', Gameway.gon.get('currentUser'));
  }.property('Gameway.gon.currentUser')
})
