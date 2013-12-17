Gameway.Tournament = DS.Model.extend(
  title: DS.attr('string')
  game: DS.attr()
  description: DS.attr('string')
  rules: DS.attr()
  starts_at: DS.attr('date')
  bracket: DS.attr()
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
)
