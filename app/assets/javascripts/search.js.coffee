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

  $('.moderator-role-search #moderator_role_query').typeahead
    name: 'users'
    remote:
      url: "/moderator_roles?moderator_role%5Bquery%5D=%QUERY"
      filter: (parsedResponse) ->
        $.map parsedResponse.moderator_roles, (user, i) ->
          datum =
            value: user.username
            tokens: [user.username, user.first_name, user.last_name]
            username: user.username
            full_name: user.full_name
            avatar_url: user.avatar_url
          return datum
    engine: Hogan
    template: "<img src={{avatar_url}}><p><strong>{{username}}</strong>  {{full_name}}</p>"
