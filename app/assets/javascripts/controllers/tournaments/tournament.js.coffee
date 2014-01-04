Gameway.IndexController = Ember.ObjectController.extend(
  needs: ['currentUser']
  actions:
    individualSignup: ->
      membership = this.store.createRecord('tournament_membership', {tournamentId: @get('id'), userId: true})
      membership.save()

    start: (showing) ->
      $.ajax
        url: "#{location.origin}/tournaments/#{@get('id')}/start"
        type: 'POST'
        data: {tournament: {start: true}}
      @get('model').reload()

    edit: ->
      window.location.href = "#{location.origin}/tournaments/#{@get('id')}/edit"

    advanceSlot: (showing) ->
      # debugger
      position = @calculatePosition(showing)
      if position[1] % 2 == 0
        top = true
      else
        top = false

      if @get('isTeamMode')
        # showing = @store.createRecord('teamShowing', {userId: showing.get('userId'), matchId: , top: top})
      else
        next_match = showing.get("match.next")
        new_showing = @store.createRecord("userShowing",
          top: top
          match: next_match
          user: showing.get('user')
        )
        # new_showing = @store.createRecord('userShowing', {userId: showing.user_id, matchId: next_match.get('id'), top: top})
        next_match.get('userShowings').addObject(new_showing)
        # .then(success, error)
        new_showing.save().then(null, (error) -> Gameway.Flasher.error("THERE WAS AN ERROR #{error.message}"))

    deleteSlot: (showing) ->
      showing.destroyRecord()

  isTeamMode: (->
    # console.log @get('liveStreamers')[0][1]
    # console.log @get('bracket')
    if @get('mode') == 'team'
      return true
    else if @get('mode') == 'individual'
      return false
  ).property('mode')

  displayIndividualSignup: (->
    return @get('mode') == 'individual' and @get('open') and !@get('started')
  ).property('mode', 'open', 'started')

  isOwner: (->
    return parseInt(@get('controllers.currentUser').get('content').get('id')) == @get('owner').user.id
  ).property('owner', 'controllers.currentUser')

  hasModeratorAccess: (->
    current_user_id = parseInt(@get('controllers.currentUser').get('content').get('id'))
    moderator_ids = @get('moderators').mapBy('id')
    owner_id = @get('owner').user.id
    return moderator_ids.contains(current_user_id) or current_user_id == owner_id
  ).property('moderators', 'owner', 'controllers.currentUser')

  participantCount: (->
    if @get('isTeamMode')
      return "There are #{@get('teams.length')} teams participating"
    else
      return "There are #{@get('users.length')} users participating"
  ).property('teams', 'users')

  calculatePosition: (showing) ->
    self = this
    position = null
    @get('bracket').every (round, ri) ->
      round.compact().every (match, mi) ->
        if self.get('isTeamMode')
          match.get('teamShowings').every (team_showing) ->
            if team_showing.id == showing.id
              ti = 1
              ti = 0 if team_showing.top
              position = [ri, mi, ti]
              return false
            else
              return true
        else
          match.get('userShowings').every (user_showing) ->
            if user_showing.id == showing.id
              ui = 1
              ui = 0 if user_showing.top
              position = [ri, mi, ui]
              return false
            else
              return true
    return position

  ## Maybe I can convert bracket/bracket_controller.rb to ember too
  # calculateRounds:
)
