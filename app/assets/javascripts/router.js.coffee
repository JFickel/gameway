# For more information see: http://emberjs.com/guides/routing/

Gameway.Router.map ()->
  @resource 'tournament_membership', { path: "/tournament_memberships/:tournament_membership_id"}
  # @resource(
  #   'tournament'
  #   { path: "/tournaments/:tournament_id"}
  # )
  # @resource('posts')
  # @route('about')

