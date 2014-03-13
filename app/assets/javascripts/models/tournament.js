attr = DS.attr;

Gameway.Tournament = DS.Model.extend({
  title: attr('string'),
  description: attr('string'),
  createdAt: attr('date'),
  updatedAt: attr('date')
})
