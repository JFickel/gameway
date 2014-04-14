Gameway.IndexController = Gameway.Controller.extend({
  currentTournaments: function() {
    return this.get('currentUser.tournaments').filterBy('ended', false);
  }.property('currentUser.tournaments.@each'),
  pastTournaments: function() {
    return this.get('currentUser.tournaments').filterBy('ended');
  }.property('currentUser.tournaments.@each')
});
