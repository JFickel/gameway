Gameway.CurrentUserRoute = Ember.Route.extend
  model: ->
    return @store.find('user', 'current')
