attr = DS.attr;

Gameway.Matchup = DS.Model.extend({
  match: DS.belongsTo('match'),
  user: DS.belongsTo('user'),
  team: DS.belongsTo('team'),
  top: attr('boolean')
})
