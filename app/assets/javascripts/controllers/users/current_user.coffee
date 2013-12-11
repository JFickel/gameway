Gameway.CurrentUserController = Ember.ObjectController.extend
  isSignedIn: (->
    # console.log @get('model').get('user')
    return this.get('content') && this.get('content').get('isLoaded')
  ).property('content.isLoaded')
