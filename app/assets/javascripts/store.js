// http://emberjs.com/guides/models/using-the-store/

Gameway.ApplicationSerializer = DS.ActiveModelSerializer.extend({});

$(function() {
  var token = Gameway.gon.get('authenticityToken');
  return $.ajaxPrefilter(function(options, originalOptions, xhr) {
      return xhr.setRequestHeader('X-CSRF-Token', token);
  });
});
