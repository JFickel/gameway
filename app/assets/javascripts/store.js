var firebaseRef = new Firebase('https://gameway.firebaseio.com/')

Gameway.ApplicationSerializer = DS.ActiveModelSerializer.extend({});

Gameway.BracketAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.BracketSerializer = DS.FirebaseSerializer.extend();

Gameway.RoundAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.RoundSerializer = DS.FirebaseSerializer.extend();

Gameway.MatchAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.MatchSerializer = DS.FirebaseSerializer.extend();

Gameway.MatchupAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.MatchupSerializer = DS.FirebaseSerializer.extend();

$(function() {
  var token = Gameway.gon.get('authenticityToken');
  return $.ajaxPrefilter(function(options, originalOptions, xhr) {
      return xhr.setRequestHeader('X-CSRF-Token', token);
  });
});
