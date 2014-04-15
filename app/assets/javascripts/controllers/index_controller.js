Gameway.IndexController = Gameway.Controller.extend({
  currentTournaments: function() {
    if (this.get('currentUser.tournaments')) {
      return this.get('currentUser.tournaments').filterBy('ended', false);
    }
  }.property('currentUser.tournaments.@each'),
  pastTournaments: function() {
    if (this.get('currentUser.tournaments')) {
      return this.get('currentUser.tournaments').filterBy('ended');
    }
  }.property('currentUser.tournaments.@each')
});
