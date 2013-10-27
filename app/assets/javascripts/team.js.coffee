$ ->
  $('.add-affiliation').on "submit", ".user-search", (event) ->
    event.preventDefault()
    [first, mid...,team_id] = $('.edit_team').attr('action').split("/")
    $.ajax(
      type: 'GET'
      url: '/users'
      dataType: 'json'
      data:
        user:
          query: $(this).parent().find('#user_query').val()
      success: (data) ->
        $('.affiliation-candidates').empty()
        users = data.users
        output = ""
        $.each users, (index, user) ->
            output += "<div><h4>#{user.username}</h4><p>#{user.full_name}</p>"
            $('.affiliation-candidate-form').find('#affiliation_affiliate_team_id').val(user.id)
            $('.affiliation-candidate-form').find('#affiliation_affiliated_team_id').val(tournament_id)
            $('.affiliation-candidate-form').find('#affiliation_affiliated_group_id').val(tournament_id)
            $('.affiliation-candidate-form').find('#affiliation_affiliated_tournament_id').val(tournament_id)
            output += $('.affiliation-candidate-form').html()
            output += "</div>"
        $('.affiliation-candidates').append(output)
    )

  # Waiting for typeahead.js to implement a method to clear dataset cache. JQuery#typeahead('destroy') does not do what I need

  setTypeAhead = (table, template) ->
    $('.affiliation-search #affiliation_query').typeahead('destroy')
    $('.affiliation-search #affiliation_query').typeahead
      name: 'affiliations'
      remote:
        url: "/#{table}?%5Bquery%5D=%QUERY"
        filter: (parsedResponse) ->
          if table is 'groups'
            $.map parsedResponse['groups'], (group, i) ->
              console.log group
              datum =
                value: group.name
                tokens: [group.name, group.kind]
                kind: group.kind
              return datum
          else if table is 'tournaments'
            $.map parsedResponse['tournaments'], (tournament, i) ->
              datum =
                value: tournament.title
                tokens: [tournament.title]
              return datum
          else if table is 'teams'
            $.map parsedResponse['teams'], (team, i) ->
              datum =
                value: team.name
                tokens: team.name
                avatar_url: team.avatar_url
              return datum
      engine: Hogan
      template: template


  $('.affiliation-search-filter').on "click", ".groups-filter", () ->
    table = "groups"
    template = "<strong>{{value}}</strong>{{kind}}</p>"
    setTypeAhead(table, template)

  $('.affiliation-search-filter').on "click", ".teams-filter", () ->
    table = "teams"
    template = "<img src={{avatar_url}}><p><strong>  {{value}}</strong></p>"
    setTypeAhead(table, template)

  $('.affiliation-search-filter').on "click", ".tournaments-filter", () ->
    table = "tournaments"
    template = "<p><strong>{{value}}</strong></p>"
    setTypeAhead(table, template)
