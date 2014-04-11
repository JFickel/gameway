Gameway.Controller = Ember.Controller.extend({
  gon: Gameway.gon,
  currentUser: function() {
    var currentUser;
    if (Gameway.gon.get('currentUserPayload.user') === null) { return null; }
    currentUser = this.store.getById('user', Gameway.gon.get('currentUserPayload.user.id'));
    if (!currentUser || $.isEmptyObject(currentUser._data)) {
      this.store.pushPayload('user', gon.current_user_payload)
      return this.store.getById('user', Gameway.gon.get('currentUserPayload.user.id'))
    } else {
      return this.store.getById('user', Gameway.gon.get('currentUserPayload.user.id'))
    }
  }.property('Gameway.gon.currentUserPayload')
})
