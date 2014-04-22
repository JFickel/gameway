attr = DS.attr;

Gameway.Round = DS.Model.extend({
  index: attr('number'),
  bracket: DS.belongsTo('bracket', { async: true }),
  matches: DS.hasMany('match', { async: true })
})
