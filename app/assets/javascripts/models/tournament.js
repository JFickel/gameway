attr = DS.attr;

Gameway.Tournament = DS.Model.extend({
  name: attr('string'),
  bracketId: attr('string'),
  bracket: function() {
    this.store.find('bracket', this.get('bracketId')).then(function(bracket) {
      // debugger;
      // bracket.get('rounds').then(function(rounds) {
        // debugger;
      // })
      return bracket

    }, function(error) {
      throw error
    });
  }.property('bracketId'),
  description: attr('string'),
  user: DS.belongsTo('user'),
  teams: DS.hasMany('team'),
  started: attr('boolean'),
  startsAt: attr('date'),
  ended: attr('boolean'),
  lolRegion: attr('string'),
  createdAt: attr('date'),
  updatedAt: attr('date'),
  start: function() {
    var bracket = this.store.createRecord('bracket');
    this.set('started', true);
    bracket.build({ participants: this.get('participants'), tournament: this });
    this.set('bracketId', bracket.get('id'));
    this.save();
  },
  participants: function() {
    if (Ember.isNone(this.get('users'))) {
      return this.get('teams');
    } else {
      return this.get('users');
    }
  }.property('teams', 'users')
})
