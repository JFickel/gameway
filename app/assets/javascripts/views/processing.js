Gameway.ProcessingView = Ember.View.extend({
  didInsertElement: function() {
    $('#processingModal').modal({backdrop: 'static'})
  }
})
