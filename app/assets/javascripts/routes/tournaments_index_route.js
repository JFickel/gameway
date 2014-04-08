Gameway.TournamentsIndexRoute = Gameway.Route.extend({
  model: function() {
    var region = this.get('currentUser.lolAccount.region') || "na"
    return this.store.find('tournament', { lol_region: region })
  },
  // action: {

  // }
});
