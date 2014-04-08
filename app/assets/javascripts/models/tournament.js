attr = DS.attr;

Gameway.Tournament = DS.Model.extend({
  name: attr('string'),
  description: attr('string'),
  user: DS.belongsTo('user'),
  lolRegion: attr('string'),
  createdAt: attr('date'),
  updatedAt: attr('date')
})
