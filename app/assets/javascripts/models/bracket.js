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
    this.save()
  },

  roundCount: function() {
    return Math.ceil(Math.log2(this.get('participants').length));
  },

  filterRoundParticipantCount: function() {
    // Calculates number of contestants in first (filter) round
    return (this.get('participants').length - this.filteredRoundParticipantCount()) * 2;
  },

  filteredRoundParticipantCount: function() {
    // Calculates number of contestants in second (filtered) round
    return Math.pow(2, (this.roundCount() - 1));
  },

  buildRounds: function() {
    // The winner match isn't actually a match -- it's just a holding cell for the winner
    var winnerMatchup = this.store.createRecord('matchup', { top: true }),
        winnerMatch = this.store.createRecord('match'),
        winnerRound = this.store.createRecord('round', { index: this.roundCount() }),
        roundCount =  this.roundCount(),
        roundIndex,
        matches;
    winnerMatchup.save();
    winnerMatch.get('matchups').pushObject(winnerMatchup);
    winnerMatch.save();
    winnerRound.get('matches').pushObject(winnerMatch);
    winnerRound.save();
    this.get('rounds').pushObject(winnerRound);
    for (var reverseIndex = 0; reverseIndex < roundCount; reverseIndex++) {
      roundIndex = roundCount - reverseIndex - 1;
      round = this.store.createRecord('round', { index: roundIndex });
      matches = this.buildMatches(reverseIndex);
      round.get('matches').pushObjects(matches);
      round.save()
      this.get('rounds').pushObject(round);
    }
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
      isMatchIndexEven = matchIndex % 2 ? undefined : true;
      nextMatchIndex = Math.floor(matchIndex/2);
      nextRoundIndex = this.roundCount() - reverseIndex;
      nextMatch = this.get('rounds').findBy('index', nextRoundIndex).get('matches').objectAt(nextMatchIndex);
      nextMatchup = nextMatch.get('matchups').findBy('top', isMatchIndexEven);
      matchups = [this.store.createRecord('matchup', { top: true }), this.store.createRecord('matchup')];
      matchups.forEach(function(mu) { mu.save(); })
      match = this.store.createRecord('match', { index: matchIndex, nextMatchupId: nextMatchup.get('id') });
      match.get('matchups').pushObjects(matchups);
      match.save();
      matches.push(match);
    }
    return matches
  },

  fillFilterRound: function() {
    var filterRoundParticipants = this.get('participants').slice(0, this.filterRoundParticipantCount()),
        pair, match, self = this;

    for (var eachSliceCount = 0, length = this.filterRoundParticipantCount(), matchIndex = 0;
         eachSliceCount < length;
         eachSliceCount += 2, matchIndex += 1) {

      pair = filterRoundParticipants.slice(eachSliceCount, eachSliceCount + 2);
      match = this.get('rounds').findBy('index', 0).get('matches').findBy('index', matchIndex);

      match.get('matchups').forEach(function(matchup, matchupIndex) {
        matchup.set(self.get('mode'), pair[matchIndex])
        matchup.set('top', matchIndex % 2 ? undefined : true);
        matchup.set('origin', true);
        matchup.save()
      })
    }
  },

  fillFilteredRound: function() {
    var remainingParticipants = this.get('participants').slice(this.filterRoundParticipantCount(), this.get('participants').length),
        filteredRoundMatches,
        matchRange = Math.floor(this.filterRoundParticipantCount()/4),
        firstFilteredMatch;
    if (Ember.isEmpty(remainingParticipants)) {
      return null;
    }
    filteredRoundMatches = this.get('rounds').objectAt(1).get('matches').sortBy('index').slice(matchRange, this.get('rounds').objectAt(1).get('matches').length);
    filteredRoundMatches.forEach(function(match) {
      if (remainingParticipants.length % 2 == 1) {
        firstFilteredMatchup = match.get('matchups').filterBy('top', undefined);
        firstFilteredMatchup.set(this.get('mode'), remainingParticipants.shift());
        firstFilteredMatchup.set('origin', true);
        firstFilteredMatchup.save()
        return;
      }
      match.get('matchups').forEach(function(matchup, index) {
        matchup.set(this.get('mode'), remainingParticipants.shift())
        matchup.set('top', index % 2 ? undefined : true);
        matchup.set('origin', true);
        matchup.save()
      })
    })
  }
})
