Gameway.IndexRoute = Ember.Route.extend
  model: (params) ->
    return @store.find('tournament', 1)
