Gameway.TournamentsNewController = Gameway.Controller.extend({
  name: '',
  description: '',
  regions: [
    { label: 'Brazil', value: 'br' },
    { label: 'EU Nordic & East', value: 'eune' },
    { label: 'EU West',  value: 'euw' },
    { label: 'Latin America North', value: 'lan' },
    { label: 'Latin America South', value: 'las' },
    { label: 'North America', value: 'na' },
    { label: 'Oceania', value: 'oce' }
  ],
  selectedRegion: function() {
    return this.get('currentUser.lolAccount.region') || "na"
  }.property('currentUser.lolAccount.region'),
  selectedRegionLabel: '',
  actions: {
    create: function() {
      var thisController = this;
      this.store.createRecord('tournament', {
        name: this.get('name'),
        description: this.get('description'),
        user: this.get('currentUser'),
        lolRegion: this.get('selectedRegion')
      }).save().then(function (tournament) {
        thisController.transitionToRoute('tournament', tournament)
      })
    }
  }
})
