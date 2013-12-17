Gameway.Match = DS.Model.extend
  # next: DS.belongsTo('match')
  previous: DS.attr('')


  tournament: DS.belongsTo('tournament')
  userShowings: DS.hasMany('userShowing')
  teamShowings: DS.hasMany('teamShowing')

  # next: DS.hasMany('Gameway.NextMatch')
  # previous: (->
  #   @get('next').map((data)-> Gameway.Match.find(data.get('nextMatchId')))
  # )



# Gameway.NextMatch = DS.Model.extend
#   match: DS.belongsTo('Gameway.Match')
#   nextMatchId: DS.attr()

# App.User = DS.Model.extend
#   name: DS.attr('string')
#   follows: DS.hasMany('App.Follow')
#   followers:(->
#     @get('follows').map((data)-> App.User.find(data.get('followedUserId')))
#   ).property('follows.@each')

# App.Follow = Ds.Model.extend
#   user: DS.belongsTo('App.User')
#   followedUserId: DS.attr('string')
