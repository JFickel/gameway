Gameway.UserIndexController = Gameway.ObjectController.extend({
  divisionImageUrl: function() {
    return "https://s3.amazonaws.com/gameway-production/lol/divisions/" + this.get('lolAccount.soloTier') + "_" + this.get('lolAccount.soloRank') + ".png"
  }.property('currentUser.lolAccount')
})
