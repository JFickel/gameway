// For more information see: http://emberjs.com/guides/routing/

Gameway.Router.map(function() {
  this.resource('tournaments', function() {
    this.route('new');
  });
  this.resource('tournament', { path: '/tournaments/:tournament_id' }, function() {
    this.route('edit');
  });
});
