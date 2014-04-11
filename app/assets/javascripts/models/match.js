attr = DS.attr;

Gameway.Match = DS.Model.extend({
  index: attr('number'),
  round: DS.belongsTo('round'),
  matchups: DS.hasMany('matchup')
})
