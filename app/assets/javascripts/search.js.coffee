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
        # parsedResponse[0]
        # $('.moderator-role-search #moderator_role_user_id').val(parsedResponse[1])
        # console.log parsedResponse

# console.log "http://#{location.host}/moderator_roles?moderator_role%5Bquery%5D=%QUERY"
