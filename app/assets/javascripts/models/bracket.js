attr = DS.attr;

Gameway.Bracket = DS.Model.extend({
  tournament: DS.belongsTo('tournament'),
  rounds: DS.hasMany('round'),
  mode: attr('string'),
  game: attr('string')
})
