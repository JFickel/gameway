Gameway.IndexRoute = Ember.Route.extend
  model: (params) ->
    # console.log params
    [first, mid..., id] = document.URL.split('/')
    # console.log id
    return @store.find('tournament', id)
