attr = DS.attr;

function shuffle(o){
  for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};

Gameway.Bracket = DS.Model.extend({
  tournament: DS.belongsTo('tournament'),
  rounds: DS.hasMany('round'),
  mode: attr('string'),
  game: attr('string'),

  build: function(options) {
    if (Ember.isEmpty(options.participants)) {
      return null
    }
    this.set('participants', shuffle(options.participants.content));
    this.set('mode', this.get('participants').get('firstObject').constructor.toString().split('.').get('lastObject').toLowerCase());
    this.set('game', options.game);
    this.construct();
  },

  construct: function() {
    this.buildRounds();
    this.fillFilterRound();
    this.fillFilteredRound();
    this.reload();
  },

  buildRounds: function() {
    // The winner match isn't actually a match -- it's just a holding cell for the winner
    var winnerMatchup = this.store.createRecord('matchup', { top: true }),
        winnerMatch = this.store.createRecord('match', { matchups: matchups }),
        winnerRound = this.store.createRecord('round', { index: this.roundCount(), matches: matches })),
        roundCount =  this.roundCount();
        roundIndex,
        matches;
    winnerMatch.get('matchups').pushObject(winnerMatchup);
    winnerRound.get('matches').pushObject(winnerMatch);
    this.get('rounds').pushObject(winnerRound);
    for (var reverseIndex = 0; reverseIndex < roundCount; reverseIndex++) {
      roundIndex = roundCount - reverseIndex - 1;
      round = this.store.createRecord('round', { index: roundIndex });
      matches = buildMatches(reverseIndex);
      round.get('matches').pushObjects(matches);
      this.get('rounds').pushObject(round);
    }
  },

  roundCount: function() {
    Math.ceil(Math.log2(this.get('participants').length))
  },

  buildMatches: function(reverseIndex) {
    var matchCount = Math.pow(2, (reverseIndex + 1))/2,
        matchIndex,
        nextRoundIndex,
        nextMatchIndex,
        nextMatch,
        isMatchIndexEven
        matches = [];

    for (matchIndex = 0; matchIndex < matchCount; matchIndex++) {
      isMatchIndexEven = matchIndex % 2 ? null : true;
      nextMatchIndex = matchIndex/2;
      nextRoundIndex = roundCount - reverseIndex;
      nextMatch = this.get('rounds').findBy('index', nextRoundIndex).get('matches').objectAt(nextMatchIndex);
      nextMatchup = nextMatch.get('matchups').findBy('top', isMatchIndexEven);
      matchups = [this.store.createRecord('matchup', { top: true }), this.store.createRecord('matchup')];
      match = this.store.createRecord('match', { index: matchIndex, nextMatchupId: nextMatchup.get('id') });
      match.get('matchups').pushObjects(matchups);
      matches.push(match)
    }
    return matches
  }
})
