$ ->
  $('.tournament-search #query').typeahead
    name: 'tournaments'
    remote:
      url: "/tournaments?query=%QUERY"
      filter: (parsedResponse) ->
        $.map parsedResponse.tournaments, (tournament, i) ->
          datum =
            value: tournament.title
            tokens: [tournament.title]
          return datum
    engine: Hogan
    template: "<p><strong>{{value}}</strong></p>"



  $('.team-search #query').typeahead
    name: 'teams'
    remote:
      url: "/teams?query=%QUERY"
      filter: (parsedResponse) ->
        $.map parsedResponse.teams, (team, i) ->
          datum =
            value: team.name
            tokens: team.name
            avatar_url: team.avatar_url
          return datum
    engine: Hogan
    template: "<img src={{avatar_url}}><p><strong>  {{value}}</strong></p>"

  $('.group-search #query').typeahead
    name: 'groups'
    remote:
      url: "/groups?query=%QUERY"
      filter: (parsedResponse) ->
        $.map parsedResponse.groups, (group, i) ->
          datum =
            value: group.name
            tokens: [group.name, group.kind]
            kind: group.kind
    engine: Hogan
    template: "<strong>{{value}}</strong>  {{kind}}</p>"

  ## Implement this as a user search -- you can return users in a list and then add them as mod roles:

  $('.user-search #user_query').typeahead
    name: 'users'
    remote:
      url: "/users?query=%QUERY"
      filter: (parsedResponse) ->
        $.map parsedResponse.users, (user, i) ->
          datum =
            value: user.username
            tokens: [user.username, user.first_name, user.last_name]
            username: user.username
            full_name: user.full_name
            avatar_url: user.avatar_url
          return datum
    engine: Hogan
    template: "<img src={{avatar_url}}><p><strong>{{username}}</strong>  {{full_name}}</p>"


  $('.add-auxiliary').on "submit", ".user-search", (event) ->
    event.preventDefault()
    [first, mid...,tournament_id] = $('.edit_tournament').attr('action').split("/")

    $.ajax(
      type: 'GET'
      url: '/users'
      dataType: 'json'
      data:
        query: $(this).parent().find('#user_query').val()
      success: (data) ->
        $('.auxiliary-candidates').empty()
        users = data.users
        output = ""
        $.each users, (index, user) ->
            output += "<div><h4>#{user.username}</h4><p>#{user.full_name}</p>"
            $('.moderator-candidate-form').find('#invitation_user_id').val(user.id)
            $('.moderator-candidate-form').find('#invitation_tournament_id').val(tournament_id)
            $('.broadcaster-candidate-form').find('#invitation_user_id').val(user.id)
            $('.broadcaster-candidate-form').find('#invitation_tournament_id').val(tournament_id)
            output += $('.moderator-candidate-form').html()
            output += $('.broadcaster-candidate-form').html()
            output += "</div>"
        $('.auxiliary-candidates').append(output)
    )

  $('.add-team-member').on "submit", ".user-search", (event) ->
    event.preventDefault()
    [first, mid...,team_id] = $('.edit_team').attr('action').split("/")

    $.ajax(
      type: 'GET'
      url: '/users'
      dataType: 'json'
      data:
        query: $(this).parent().find('#user_query').val()
      success: (data) ->
        $('.team-member-candidates').empty()
        users = data.users
        output = ""
        $.each users, (index, user) ->
            output += "<div><h4>#{user.username}</h4><p>#{user.full_name}</p>"
            $('.team-member-candidate-form').find('#invitation_user_id').val(user.id)
            $('.team-member-candidate-form').find('#invitation_team_id').val(team_id)
            output += $('.team-member-candidate-form').html()
            output += "</div>"

        $('.team-member-candidates').append(output)
    )
