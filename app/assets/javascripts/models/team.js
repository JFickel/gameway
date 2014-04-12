attr = DS.attr;

Gameway.Team = DS.Model.extend({
  name: attr('string'),
  lolRegion: attr('string'),
  user: DS.belongsTo('user'),
  matchups: DS.hasMany('matchup')
})
