$ ->
  $('.tournament-search #query').typeahead
    name: 'tournaments'
    remote: "#{document.URL}?query=%QUERY"

  $('.team-search #query').typeahead
    name: 'tournaments'
    remote: "#{document.URL}?query=%QUERY"

  $('.group-search #query').typeahead
    name: 'tournaments'
    remote: "#{document.URL}?query=%QUERY"

