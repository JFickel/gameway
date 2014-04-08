Ember.Handlebars.helper('formattedLongDate', function(time) {
  return moment(time).format('dddd, MMMM Do, YYYY [at] h:mma');
});
