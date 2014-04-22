var firebaseRef = new Firebase('https://gameway.firebaseio.com/')

Gameway.ApplicationSerializer = DS.ActiveModelSerializer.extend({});

Gameway.BracketAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.FirebaseSerializer = DS.FirebaseSerializer.extend({
  serializeHasMany: function(record, json, relationship) {
    var key = relationship.key;
    var payloadKey = this.keyForRelationship ? this.keyForRelationship(key, 'hasMany') : key;
    var relationshipType = DS.RelationshipChange.determineRelationshipType(record.constructor, relationship);

    if (['manyToNone', 'manyToMany', 'manyToOne'].contains(relationshipType)) {
      json[payloadKey] = record.get(key).mapBy('id');
    }
  }
});

Gameway.BracketSerializer = Gameway.FirebaseSerializer.extend();

Gameway.RoundAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.RoundSerializer = Gameway.FirebaseSerializer.extend();

Gameway.MatchAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.MatchSerializer = Gameway.FirebaseSerializer.extend();

Gameway.MatchupAdapter = DS.FirebaseAdapter.extend({
  firebase: firebaseRef
});

Gameway.MatchupSerializer = Gameway.FirebaseSerializer.extend();

$(function() {
  var token = Gameway.gon.get('authenticityToken');
  return $.ajaxPrefilter(function(options, originalOptions, xhr) {
      return xhr.setRequestHeader('X-CSRF-Token', token);
  });
});
