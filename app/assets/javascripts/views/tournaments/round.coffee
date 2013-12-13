Gameway.RoundView = Ember.View.extend
  classNameBindings: [':round', 'roundSize']
  templateName: 'tournaments/round'
  tagName: 'ul'
  roundSize: (->
    return "round-#{@templateData.view.content.length * 2}"
  ).property('controller.bracket')
