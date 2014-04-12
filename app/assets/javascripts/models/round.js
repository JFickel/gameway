attr = DS.attr;

Gameway.Round = DS.Model.extend({
  index: attr('number'),
  bracket: DS.belongsTo('bracket'),
  matches: DS.hasMany('match')
})
