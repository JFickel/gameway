attr = DS.attr;

Gameway.Match = DS.Model.extend({
  index: attr('number'),
  round: DS.belongsTo('round', { async: true }),
  matchups: DS.hasMany('matchup', { async: true }),
  nextMatchupId: attr('string')
})
