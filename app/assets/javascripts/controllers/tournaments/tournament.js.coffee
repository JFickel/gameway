Gameway.IndexController = Ember.ObjectController.extend(
  actions:
    individualSignup: ->
      Gameway.TournamentMembership.createRecord
        tournamentId: @get('id')
        userId: 1
      # console.log "YA SIGNED UP"
      # how would I get a current user object in ember??
      # How do I even handle this?
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


)
