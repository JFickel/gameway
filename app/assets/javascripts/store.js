var firebaseRef = new Firebase('https://gameway.firebaseio.com/')

Gameway.ApplicationSerializer = DS.ActiveModelSerializer.extend({});

Gameway.BracketAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.RoundAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.MatchAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.MatchupAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

$(function() {
  var token = Gameway.gon.get('authenticityToken');
  return $.ajaxPrefilter(function(options, originalOptions, xhr) {
      return xhr.setRequestHeader('X-CSRF-Token', token);
  });
});
