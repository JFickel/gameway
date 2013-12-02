Gameway.Tournament = DS.Model.extend(
  title: DS.attr('string')
  description: DS.attr('string')
  orderedBracket: DS.attr('string')
  mode: DS.attr('string')
  current_opponent: DS.attr()
  started: DS.attr('boolean')
  live: DS.attr('boolean')
)
