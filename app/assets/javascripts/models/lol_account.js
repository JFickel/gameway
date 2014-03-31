attr = DS.attr;

Gameway.LolAccount = DS.Model.extend({
  userId: DS.belongsTo('user'),
  summonerId: attr('number'),
  summonerName: attr('string'),
  soloTier: attr('string'),
  soloRank: attr('string'),
  region: attr('string')
})
