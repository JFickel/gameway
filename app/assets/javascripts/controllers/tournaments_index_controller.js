Gameway.TournamentsIndexController = Gameway.ArrayController.extend({
  init: function() {
    var thisController = this;
    this.get('regions').forEach(function(item, index) {
      if (thisController.get('currentUser.lolAccount.region')) {
        if (thisController.get('currentUser.lolAccount.region') === item.name) {
          thisController.set('regions.' + index + '.active', true);
        }
      } else if ('na' === item.name) {
        thisController.set('regions.' + index + '.active', true);
      }
    })
  },
  regions: [
    { name: "na", label: "North America", active: false },
    { name: "euw", label: "EU West", active: false },
    { name: "eune", label: "EU Nordic & East", active: false },
    { name: "br", label: "Brazil", active: false },
    { name: "oce", label: "Oceania", active: false },
    { name: "lan", label: "Latin America North", active: false },
    { name: "las", label: "Latin America South", active: false }
  ],
  sortProperties: ['id'],
  sortAscending: true,
  currentFilter: function() {
    return this.get('currentUser.lolAccount.region') || "na"
  }.property('currentUser.lolAccount.region'),
  actions: {
    setFilter: function(region) {
      var thisController = this;
      this.get('regions').forEach(function(item, index) {
        if (item.name === region) {
          thisController.set('regions.' + index + '.active', true);
        } else {
          thisController.set('regions.' + index + '.active', false);
        }
      })
      this.set('model', this.store.find('tournament', { lol_region: region }))
    }
  }
})
