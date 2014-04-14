attr = DS.attr;

Gameway.Tournament = DS.Model.extend({
  name: attr('string'),
  bracket: DS.belongsTo('bracket'),
  description: attr('string'),
  user: DS.belongsTo('user'),
  teams: DS.hasMany('team'),
  started: attr('boolean'),
  startsAt: attr('date'),
  ended: attr('boolean'),
  lolRegion: attr('string'),
  createdAt: attr('date'),
  updatedAt: attr('date')
})
