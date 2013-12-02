Gameway.Tournament = DS.Model.extend(
  title: DS.attr('string')
  description: DS.attr('string')
  orderedBracket: DS.attr()
  mode: DS.attr('string')
  current_opponent: DS.attr()
  started: DS.attr('boolean')
  live: DS.attr('boolean')
  # bracket: (->
    # return JSON.parse(@get('orderedBracket'))
  # ).property('orderedBracket')
)
