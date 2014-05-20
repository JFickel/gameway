attr = DS.attr;

function shuffle(o){
  for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};

Gameway.Bracket = DS.Model.extend({
  // tournamnetId formatting wasn't being picked up for some reason by the serializer
  // it looks like i'll have to refer to it in this format
  tournament_id: attr('number'),
  rounds: DS.hasMany('round', { async: true }),
  mode: attr('string'),
  game: attr('string'),

  build: function(options) {
    if (Ember.isEmpty(options.participants)) {
      return null
    }
    this.set('participants', shuffle(options.participants.content));
    this.set('mode', this.get('participants').get('firstObject').constructor.toString().split('.').get('lastObject').toLowerCase());
    this.set('game', options.game);
    this.set('tournamentId', options.tournament.get('id'));
    this.construct();
  },

  construct: function() {
    this.buildRounds();
    // this.fillFilterRound();
    // this.fillFilteredRound();
    // this.save()
  },

  roundCount: function() {
    var roundCountApproximation = Math.log(this.get('participants').length) / Math.log(2);
    // debugger;
    return Math.ceil(roundCountApproximation);
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
    var thisBracket = this,
        winnerRound = this.store.createRecord('round', { index: this.roundCount(), bracket: this }),
        winnerMatch = this.store.createRecord('match', { round: winnerRound, index: 0  }),
        winnerMatchup = this.store.createRecord('matchup', { top: true, match: winnerMatch }),
        roundCount =  this.roundCount(),
        builtRounds = [],
        round,
        roundIndex,
        matches;

    var promise = new Ember.RSVP.Promise(function(resolve) {

      winnerRound.save();
      winnerMatch.save();
      winnerMatchup.save();

      winnerMatch.get('matchups').then(function(matchups) {
        matchups.pushObject(winnerMatchup);
        winnerMatch.save();
      });

      winnerRound.get('matches').then(function(matches) {
        matches.pushObject(winnerMatch);
        winnerRound.save();
      });

      builtRounds.push(winnerRound);

      resolve(0);
    });

    var _this = this;

    var iteration = function(reverseIndex) {
      roundIndex = roundCount - reverseIndex - 1;
      round = _this.store.createRecord('round', { index: roundIndex, bracket: _this });
      round.save();
      builtRounds.push(round);
      _this.buildMatches(reverseIndex, round, builtRounds);

      if (reverseIndex < roundCount) {
        promise = promise.then(iteration);
      }

      return reverseIndex + 1;
    };

    promise = promise.then(iteration);

    thisBracket.get('rounds').then(function(rounds) {
      rounds.pushObject(winnerRound);
      rounds.pushObjects(builtRounds)
      thisBracket.save();
    });
  },

  buildMatches: function(reverseIndex, round, builtRounds) {
    var matchCount = Math.pow(2, (reverseIndex + 1))/2,
        matchIndex,
        isMatchIndexEven,
        nextMatchIndex,
        nextRoundIndex,
        nextMatch,
        nextMatchup,
        thisStore = this.store,
        builtMatches = [],
        settled = false,
        match;

    for (matchIndex = 0; matchIndex < matchCount; matchIndex++) {
      isMatchIndexEven = matchIndex % 2 ? undefined : true;
      nextMatchIndex = Math.floor(matchIndex/2);
      nextRoundIndex = this.roundCount() - reverseIndex;
      debugger;
      builtRounds.findBy('index', nextRoundIndex).get('matches').then(function(matches) {
        reverseIndex, round, builtRounds, nextRoundIndex;
        debugger;
        // if (typeof matches.findBy('index', nextMatchIndex) === "undefined") {
          // builtRounds.findBy('index', 4).get('matches').then(function(matches) {
            // reverseIndex, round, builtRounds, nextRoundIndex;
          // })
        // }

        return matches.findBy('index', nextMatchIndex);
      }).then(function(nextMatch) {
        nextMatch.get('matchups').then(function(matchups) {
          nextMatchup = matchups.findBy('top', isMatchIndexEven);
          match = thisStore.createRecord('match', { index: matchIndex, nextMatchupId: nextMatchup.get('id'), round: round });
          match.save();
          builtMatches.push(match);
          return match
        }).then(function(match) {
          topMatchup = thisStore.createRecord('matchup', { top: true, match: match });
          bottomMatchup = thisStore.createRecord('matchup', { match: match });
          topMatchup.save();
          bottomMatchup.save();
          match.get('matchups').then(function(matchups) {
            matchups.pushObject(topMatchup);
            matchups.pushObject(bottomMatchup);
            match.save();
          });
        })
      })
    }
    round.get('matches').then(function(matches) {
      matches.pushObjects(builtMatches);
      round.save()
    })
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
