attr = DS.attr;

Gameway.User = DS.Model.extend({
  name: attr('string'),
  email: attr('string'),
  lolAccount: DS.belongsTo('lolAccount'),
  avatarUrl: attr('string'),
  iconUrl: attr('string'),
  teams: DS.hasMany('team'),
  tournaments: DS.hasMany('tournament')
})
