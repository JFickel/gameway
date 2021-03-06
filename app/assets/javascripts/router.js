// For more information see: http://emberjs.com/guides/routing/

Gameway.Router.map(function() {
  this.resource('tournaments', function() {
    this.route('new');
  });
  this.resource('tournament', { path: '/tournaments/:tournament_id' }, function() {
    this.route('edit');
  });

  this.resource('users', function() {
    this.route('new');
  });
  this.resource('user', { path: '/users/:user_id'}, function() {
    this.route('edit');
  });

  this.resource('teams', function() {
    this.route('new');
    this.route('show');
  });
  this.resource('team', { path: '/teams/:team_id' }, function() {
    this.route('edit');
  })
});
