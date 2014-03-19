Gameway.AlertView = Ember.View.extend({
  templateName: '_alert',
  classNameBindings: [ 'defaultClass', 'defaultType', 'content.type' ],
  defaultClass: 'alert',
  defaultType: function() {
    if (!this.get('content.type')) {
      return 'alert-info'
    }
  }.property(),
  controllerBinding: 'content',
  click: function() {
    var thisView = this;
    this.$().fadeOut(300, function() { thisView.removeFromParent(); })
  },
  didInsertElement: function() {
    this.$().hide().fadeIn(300);
  }
})
