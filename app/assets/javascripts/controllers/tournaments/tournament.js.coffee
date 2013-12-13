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
    # console.log @get('bracket')
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
    if parseInt(@get('controllers.currentUser').get('content').get('id')) == @get('owner').user.id
      return true
    else
      return false
  ).property('owner', 'controllers.currentUser')

  hasModeratorAccess: (->
    current_user_id = parseInt(@get('controllers.currentUser').get('content').get('id'))
    moderator_ids = @get('moderators').mapBy('id')
    owner_id = @get('owner').user.id
    if moderator_ids.contains(current_user_id) or current_user_id == owner_id
      return true
    else
      return false
  ).property('moderators', 'owner', 'controllers.currentUser')
)
