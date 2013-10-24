$ ->
  $('.tournament-search #query').typeahead
    name: 'tournaments'
    remote: "#{document.URL}?query=%QUERY"

  $('.team-search #query').typeahead
    name: 'teams'
    remote: "#{document.URL}?query=%QUERY"

  $('.group-search #query').typeahead
    name: 'groups'
    remote: "#{document.URL}?query=%QUERY"

  $('.moderator-role-search #moderator_role_query').typeahead
    name: 'users'
    remote:
      url: "/moderator_roles?moderator_role%5Bquery%5D=%QUERY"
      filter: (parsedResponse) ->
        # console.log parsedResponse.moderator_roles
        $.map parsedResponse.moderator_roles, (user, i) ->
          datum =
            value: user.username
            tokens: [user.username, user.first_name, user.last_name]
            username: user.username
            full_name: user.full_name
            avatar_url: user.avatar_url
          return datum
    engine: Hogan
    template: "<img src={{avatar_url}} height='42' width='42'><p><strong>{{username}}</strong>{{full_name}}</p>"

  $('#moderator_role_query').bind 'typeahead:autocompleted', (datum, dataset) ->
    console.log dataset
    console.log datum


  # $('#moderator_role_query').bind 'typeahead:selected', (datum, dataset) ->
  #   console.log dataset
  #   console.log datum
