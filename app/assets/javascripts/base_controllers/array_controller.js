Gameway.ArrayController = Ember.ArrayController.extend({
  gon: Gameway.gon,
  currentUser: function() {
    if (Gameway.gon.get('currentUserPayload.user') === null) { return null; }
    if (!this.store.getById('user', Gameway.gon.get('currentUserPayload.user.id'))) {
      this.store.pushPayload('user', gon.current_user_payload)
      return this.store.getById('user', Gameway.gon.get('currentUserPayload.user.id'))
    } else {
      return this.store.getById('user', Gameway.gon.get('currentUserPayload.user.id'))
    }
  }.property('Gameway.gon.currentUserPayload')
})
