Gameway.initializer
  name: 'currentUser'

  initialize: (container, application) ->
    store = container.lookup('store:main')
    user = store.find('user', 'current')
    # user = Gameway.User.find('current')

    container.lookup('controller:currentUser').set('content', user)
    container.typeInjection('controller', 'currentUser', 'controller:currentUser')
