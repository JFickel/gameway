Gameway.CurrentUserController = Ember.ObjectController.extend
  isSignedIn: (->
    return this.get('content') && this.get('content').get('isLoaded')
  ).property('content.isLoaded')
