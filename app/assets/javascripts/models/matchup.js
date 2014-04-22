attr = DS.attr;

Gameway.Matchup = DS.Model.extend({
  match: DS.belongsTo('match', { async: true }),
  // matchId: attr('string'),
  // user: DS.belongsTo('user'),
  userId: attr('string'),
  // team: DS.belongsTo('team'),
  teamId: attr('string'),
  top: attr('boolean'),
  origin: attr('boolean')
})
