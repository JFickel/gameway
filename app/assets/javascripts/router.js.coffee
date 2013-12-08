# For more information see: http://emberjs.com/guides/routing/

Gameway.Router.map ()->
  @resource 'tournament_membership', { path: "/tournament_memberships/:tournament_membership_id"}

  # @resource 'current_user', {path: '/users/current'}
  @resource 'user', { path: '/users/:user_id'}

  # @resource(
  #   'tournament'
  #   { path: "/tournaments/:tournament_id"}
  # )
  # @resource('posts')
  # @route('about')

