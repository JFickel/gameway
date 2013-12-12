Gameway.IndexController = Ember.ObjectController.extend(
  needs: ['currentUser']
  actions:
    individualSignup: ->
      membership = this.store.createRecord('tournament_membership', {tournamentId: @get('id'), userId: true})
      membership.save()

      # return false
      # console.log "YA SIGNED UP"
      # how would I get a current user object in ember??
      # How do I even handle this?
    start: ->
      $.ajax
        url: "#{location.origin}/tournaments/#{@get('id')}/start"
        type: 'POST'
        data: {tournament: {start: true}}
    edit: ->
      window.location.href = "#{location.origin}/tournaments/#{@get('id')}/edit"
  isTeamMode: (->
    # console.log @get('liveStreamers')[0][1]
    console.log @get('bracket')
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

  isOwner: (->
    # console.log parseInt(@get('controllers.currentUser').get('content').get('id'))
    # console.log @get('owner').user.id
    # console.log @get('controllers.currentUser').get('id')
    if parseInt(@get('controllers.currentUser').get('content').get('id')) == @get('owner').user.id
      return true
    else
      return false

    # console.log currentUser.content
    # console.log @get('owner')
    # console.log @get('owner').user
    # return @get('owner').user
  ).property('owner')
)
