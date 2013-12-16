Gameway.IndexController = Ember.ObjectController.extend(
  needs: ['currentUser']
  actions:
    individualSignup: ->
      membership = this.store.createRecord('tournament_membership', {tournamentId: @get('id'), userId: true})
      membership.save()


    start: (showing) ->
      console.log @get('users')
      # position = @calculatePosition(showing)
      # console.log position
      # @advanceSlot position, showing
      # self = this
      # $.ajax
      #   url: "#{location.origin}/tournaments/#{@get('id')}/start"
      #   type: 'POST'
      #   data: {tournament: {start: true}}
      # @get('model').reload()


    edit: ->
      window.location.href = "#{location.origin}/tournaments/#{@get('id')}/edit"


    # NONONO!!! This should all be done with ember-data
    advanceSlot: (showing) ->
      self = this
      $.ajax
        type: 'POST'
        url: '/slots'
        dataType: 'json'
        data:
          showing_id: showing_id
          id: @get('id')
      @get('model').reload()
        success: (data) ->
          console.log data
          this.get('model').reload()


    deleteSlot: (showing) ->
      $ajax
        type: 'DELETE'
        url: '/slots'
        dataType: 'json'
        data:
          showing_id: showing_id
          id: @get('id')
        success: (data) ->
          console.log data
          # @get('model').reload()


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
      return "There are #{@get('team').length} teams participating"
    else
      return "There are #{@get('users').length} users participating"
  ).property('teams', 'users')

  calculatePosition: (showing) ->
    self = this
    position = null
    @get('bracket').every (round, ri) ->
      round.compact().every (match, mi) ->
        if self.get('isTeamMode')
          match.team_showings.every (team_showing) ->
            if team_showing.id == showing.id
              ti = 1
              ti = 0 if team_showing.top
              position = [ri, mi, ti]
              return false
            else
              return true
        else
          match.user_showings.every (user_showing) ->
            if user_showing.id == showing.id
              ui = 1
              ui = 0 if user_showing.top
              position = [ri, mi, ui]
              return false
            else
              return true
    return position

  advanceSlot: (position, showing) ->
    # Determine whether slot is top or bottom
    if position[1] % 2 == 0
      top = true
    else
      top = false

    # Find next match
    next_match = @get('bracket')[position[0]+1][Math.floor(position[1]/2)]

    # If next match is nil, create a new one and place in correct position
    if next_match is null
      next_match = @store.createRecord('match', {tournamentId: @get('id')})
      @get('matches').pushObject(next_match)
      @get('bracket')[position[0]+1][Math.floor(position[1]/2)] = next_match
      next_match.save()

    # Add new user/team showing to the next match
    if @get('isTeamMode')
      new_showing = @store.createRecord('teamShowing', {teamId: showing.team_id, top: top, matchId: next_match.id})
    else
      new_showing = @store.createRecord('userShowing', {userId: showing.user_id, top: top, matchId: next_match.id})

    new_showing.save()
    @get('model').save()


  ## Maybe I can convert bracket/bracket_controller.rb to ember too
  # calculateRounds:
)
