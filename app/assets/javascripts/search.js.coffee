$ ->
  $('.tournament-search #query').typeahead
    name: 'tournaments'
    remote: 'http://localhost:3000/tournaments?query=%QUERY'
