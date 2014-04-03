attr = DS.attr;

Gameway.User = DS.Model.extend({
  email: attr('string'),
  lolAccountId: DS.belongsTo('lolAccount'),
  avatarUrl: attr('string')
})
