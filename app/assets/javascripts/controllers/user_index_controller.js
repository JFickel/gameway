Gameway.UserIndexController = Gameway.ObjectController.extend({
  divisionImageUrl: function() {
    return "https://s3.amazonaws.com/gameway-production/lol/divisions/" + this.get('lolAccountId.soloTier') + "_" + this.get('lolAccountId.soloRank') + ".png"
  }.property('currentUser.lolAccountId')
})
