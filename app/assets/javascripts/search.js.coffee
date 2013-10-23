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

  $('.moderator-role-search #query').typeahead
    name: 'users'
    remote: "http://#{location.host}/moderator_roles?query=%QUERY"

console.log "http://#{location.host}/moderator_roles?query=%QUERY"
