Gameway.Tournament = DS.Model.extend(
  title: DS.attr('string')
  game: DS.attr()
  description: DS.attr('string')
  rules: DS.attr()
  starts_at: DS.attr('date')

  # bracket: DS.castManyMany('match')

  mode: DS.attr('string')
  current_opponent: DS.attr()
  started: DS.attr('boolean')
  live: DS.attr('boolean')
  open: DS.attr('boolean')
  openApplications: DS.attr('boolean')
  maximumParticipants: DS.attr()
  liveStreamers: DS.attr()

  owner: DS.attr()

  # users: DS.attr()
  # teams: DS.attr()
  # matches: DS.attr()

  users: DS.hasMany('user')
  teams: DS.hasMany('team')
  matches: DS.hasMany('match')

  moderators: DS.hasMany('moderator')
  broadcasters: DS.hasMany('broadcaster')

  bracket: (->
    rounds = { }
    @get('matches').forEach (match) ->
      round_index = match.get('roundIndex')
      round = rounds[round_index] = rounds[round_index] || []
      round.push(match)
    # equivalent to Hash#values
    Object.keys(rounds).sort().map((round) -> rounds[round])
  ).property("matches")
)
