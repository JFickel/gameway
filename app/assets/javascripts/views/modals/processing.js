Gameway.ModalsProcessingView = Ember.View.extend({
  didInsertElement: function() {
    $('#processingModal').modal({backdrop: 'static'})
  }
})
