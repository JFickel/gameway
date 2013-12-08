Gameway.Router.map ()->
  @resource 'tournament_membership', { path: "/tournament_memberships/:tournament_membership_id"}

  @resource 'user', { path: '/users/:user_id'}

  # @resource(
  #   'tournament'
  #   { path: "/tournaments/:tournament_id"}
  # )
  # @resource('posts')
  # @route('about')

