Gameway.IndexController = Ember.ObjectController.extend(
  isTeamMode: (->
    if @get('mode') == 'team'
      return true
    else if @get('mode') == 'individual'
      return false
  ).property('mode')

  displayIndividualSignup: (->
    if @get('mode') == 'individual' and @get('open') and !@get('started')
      return true
    else
      return false
  ).property('mode', 'open', 'started')

  # individualSignup: ->
    # Gameway.TournamentMembership.createRecord
      # tournamentId: @get('id')
      # userId: is there a way to get a current user object in ember??
  ## How do I even handle this?


  # test: (->
    # console.log @get('orderedBracket')
    # console.log "TEST"
  # ).property('orderedBracket')
    # return @store.get('orderedBracket')
)
