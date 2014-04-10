attr = DS.attr;

Gameway.Bracket = DS.Model.extend({
  tournament: DS.belongsTo('tournament'),
  structure: attr(),
  mode: attr('string')
})
