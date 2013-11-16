$ ->
  $('#tournament_start_date').datepicker
    dateFormat: 'yy-mm-dd'
  $('.bracket_data').hide()
  $('.update_path').hide()
  $('.tournament_id').hide()
  $('.matches').hide()
  $('.moderator-status').hide()

  $('.tournament-delete-btn').click () ->
    return confirm("Are you sure you want to delete this tournament?")




  class BracketView
    constructor: (options) ->
      {@moderatorStatus, @matchHeight, @matchPadding, @matchWidth, @matchBorder} = options

    determineClassRound: (round_index, round, self) ->
      # console.log self.bracket
      # console.log round

      if round_index == self.bracket.length-1
        return "<ul class='round winner'>"
      else
        return "<ul class='round round-#{round.length*2}'>"

    renderBracket: (@tournament) ->
      @bracket = @tournament.ordered_bracket
      @mode = @tournament.mode
      $('.participants').hide()
      $('.tournament-sign-up-btn').hide()
      output = ""
      self = this
      $.each @bracket, (round_index, round) ->
        output += self.determineClassRound(round_index, round, self)
        $.each round, (match_index, match) ->
          output += "<li><div class='match'>"
          output += self.determineHeader(round_index, round, match_index, self)
          if match != null
            if self.mode == "individual"
              $.each match.user_showings, (user_showing_index, user_showing) ->
                if self.moderatorStatus is "true"
                  output += "<div class='slot' data-model-id='#{user_showing.user_id}'><a class='delete-slot-btn' data-delete-slot='[#{round_index},#{match_index},#{user_showing_index}]' data-username='#{user_showing.username}'>x</a>"
                  output += "<button class='advance-slot' data-position='[#{round_index},#{match_index},#{user_showing_index}]'>#{user_showing.username}</button></div>"
                else if self.moderatorStatus is "false"
                  output += "<a href='/users/#{user_showing.user_id}' class='slot' data-model-id='#{user_showing.user_id}'>#{user_showing.username}</a>"
            else if self.mode == "team"
              $.each match.team_showings, (team_showing_index, team_showing) ->
                if self.moderatorStatus is "true"
                  output += "<div class='slot' data-model-id='#{team_showing.team_id}'><a class='delete-slot-btn' data-delete-slot='[#{round_index},#{match_index},#{team_showing_index}]' data-username='#{team_showing.team_name}'>x</a>"
                  output += "<button class='advance-slot' data-position='[#{round_index},#{match_index},#{team_showing_index}]'>#{team_showing.team_name}</button></div>"
                else if self.moderatorStatus is "false"
                  output += "<a href= '/teams/#{team_showing.team_id}' class='slot' data-model-id='#{team_showing.team_id}'>#{team_showing.team_name}</a>"

          output += "</div></li>"
        output += "</ul>"
        $(".bracket").append output
        output = ""
      @setStyles()

    determineHeader: (round_index, round, match_index, self) ->
      # console.log self.bracket
      # console.log round
      if round_index == self.bracket.length - 1
        return "<div class='match-header'> Winner </div>"
      else if round.length == 1
        return "<div class='match-header'> Finals </div>"
      else if round.length == 2
        return "<div class='match-header'> Semi-Finals </div>"
      else
        return "<div class='match-header'> Ro#{round.length*2} Match #{match_index+1} </div>"

    setStyles: ->
      matchTotalHeight = @matchHeight + (2*@matchPadding[0]) + 2*@matchBorder
      self = this
      $.each @bracket, (round_index, round) ->
        if round_index == 0
          # console.log round
          $(".round-#{round.length*2} li").css('border-top', "0px solid white")
          $(".round-#{round.length*2} li").css('padding-top', "11px")
          $(".round-#{round.length*2} li:first-child").css('border-top', "1px solid black")

        marginTop = (Math.pow(2, round_index-1)*matchTotalHeight) - matchTotalHeight/2
        marginBottom = 2*marginTop
        # console.log self.bracket
        if round_index == self.bracket.length - 1
          marginTop = (Math.pow(2, round_index-2)*matchTotalHeight) - matchTotalHeight/2
          marginBottom = 2*marginTop
          $(".winner").css('margin-top', "#{marginTop}px")
        else
          $(".round-#{round.length*2}").css('margin-top', "#{marginTop}px")
          $(".round-#{round.length*2} li").css('margin-bottom', "#{marginBottom}px")

        if round_index > 1 && round_index != self.bracket.length - 1
          correctedHeight = (Math.pow(2, round_index-1)*50)
          correctedPadding = (Math.pow(2, round_index-1)*10)+(Math.pow(2, round_index-1)-1)
          if round_index-1 > 0
            marginTop = Math.pow(2, round_index-2)*matchTotalHeight
            marginBottom = Math.pow(2, round_index-2)*matchTotalHeight*2

          $(".round-#{round.length*2}").css('margin-top', "#{marginTop}px")
          $(".round-#{round.length*2} li").css('margin-bottom', "#{marginBottom}px")

          $(".round-#{round.length*2} li").css('height', "70px")
          $(".round-#{round.length*2} li").css('padding', "#{((correctedHeight-70)/2)+correctedPadding}px 10px")

  bracketView = new BracketView
    moderatorStatus: $('.moderator-status').text()
    matchHeight: 50
    matchPadding: [10, 10]
    matchWidth: 100
    matchBorder: 1

  if $('.bracket_data').text() != ""
    tournamentSerializerJSON = $('.bracket_data').text()
    tournament = JSON.parse(tournamentSerializerJSON).tournament
    current_opponent = tournament.current_opponent
    bracketView.renderBracket(tournament)

  if current_opponent
    if user = current_opponent.user
      $('.participant_panel')

    else if team = current_opponent.team
      $('.participant-panel .opponent').append("<a href='#{team.team_url}'><img src=#{team.avatar_url}></a><h3><a href='#{team.team_url}'>#{team.name}</a></h3>")

  $('.bracket').on 'mouseenter', '.slot', () ->
    user_id = $(this).data('model-id')
    $.map $('.round').find(".slot[data-model-id='#{user_id}']").get(), (slot, i) ->
      $(slot).addClass("highlighted")

  $('.bracket').on 'mouseleave', '.slot', () ->
    user_id = $(this).data('model-id')
    $.map $('.round').find(".slot[data-model-id='#{user_id}']").get(), (slot, i) ->
      $(slot).removeClass("highlighted")


  $('.bracket').on 'mouseenter', '.delete-slot-btn', () ->
    $(this).parent().addClass("delete-highlight")
    user_id = $(this).parent().data('model-id')
    $.map $('.round').find(".slot[data-model-id='#{user_id}']").get(), (slot, i) ->
      $(slot).removeClass("highlighted")

  $('.bracket').on 'mouseleave', '.delete-slot-btn', () ->
    $(this).parent().removeClass("delete-highlight")


  $('.bracket').on('click', 'button.advance-slot', () ->
    $(this).css("outline", "none")
    $.ajax(
      type: 'POST'
      url: '/slots'
      dataType: 'json'
      data:
        position: $(this).data('position')
        id: $('.tournament_id').text()
      success: (data) ->
        $('.bracket').empty()
        bracketView.renderBracket(data.tournament)
    )
  )

  $('.bracket').on('click', '.delete-slot-btn', () ->
    if confirm "Are you sure you want to delete this slot? Round-#{$(this).data('delete-slot')[0]+1} Match-#{$(this).data('delete-slot')[1]+1} #{$(this).data('username')}. This action is NOT reversible."
      $.ajax(
        type: 'DELETE'
        url: '/slots'
        dataType: 'json'
        data:
          destroy: $(this).data('delete-slot')
          id: $('.tournament_id').text()
        success: (data) ->
          $('.bracket').empty()
          bracketView.renderBracket(data.tournament)
      )
  )

  if $('#tournament_open').val() is "true"
      $('#tournament_open_applications').hide()
      $('#tournament_open_applications').val("false")
    else if $('#tournament_open').val() is "false"
      $('#tournament_open_applications').show()

  $('.new_tournament').on 'change', '#tournament_open', () ->
    if $('#tournament_open').val() is "true"
      $('#tournament_open_applications').hide()
      $('#tournament_open_applications').val("false")
    else if $('#tournament_open').val() is "false"
      $('#tournament_open_applications').show()

  $('.edit_tournament').on 'change', '#tournament_open', () ->
    if $('#tournament_open').val() is "true"
      $('#tournament_open_applications').hide()
      $('#tournament_open_applications').val("false")
    else if $('#tournament_open').val() is "false"
      $('#tournament_open_applications').show()














#################### OLD ########################

  # $('#tournament_start_date').datepicker
  #   dateFormat: 'yy-mm-dd'
  # $('.bracket_data').hide()
  # $('.update_path').hide()
  # $('.tournament_id').hide()
  # $('.matches').hide()
  # $('.moderator-status').hide()

  # $('.tournament-delete-btn').click () ->
  #   return confirm("Are you sure you want to delete this tournament?")

  # if $('.bracket_data').text() != ""
  #   bracketJSON = JSON.parse($('.bracket_data').text())




  # renderModeratorBracket = (bracket) ->
  #   $('.participants').hide()
  #   output = ""
  #   $.each bracket, (bracket_index, bracket_value) ->
  #     if bracket_index == bracket.length-1
  #       output += "<ul class='round winner'>"
  #     else
  #       output += "<ul class='round round-#{bracket_value.length*2}'>"
  #     $.each bracket_value, (array_index, array_value) ->
  #       if array_index == 0
  #         output_class = " first"
  #       output += "<li class='#{output_class}'>"
  #       output += "<div class='match'>"
  #       if bracket_index == bracket.length - 1
  #         output += "<div> Winner </div>"
  #       else if bracket_value.length == 1
  #         output += "<div> Finals </div>"
  #       else if bracket_value.length == 2
  #         output += "<div> Semi-Finals </div>"
  #       else
  #         output += "<div> Ro#{bracket_value.length*2} Match #{array_index+1} </div>"
  #       if array_value != null
  #         $.each array_value, (user_index, user_value) ->
  #           output += "<a class='delete-slot' data-delete-slot='[#{bracket_index},#{array_index},#{user_index}]' data-username='#{user_value}'>x</a><button class='slot' data-position='[#{bracket_index},#{array_index},#{user_index}]'>#{user_value}</div>"
  #       output += "</div>"
  #       output += "</li>"
  #     output += "</ul>"
  #     $(".bracket").append output
  #     output = ""


  #   pairHeight = 50
  #   pairPadding = [10, 35]
  #   pairWidth = 100
  #   pairBorder = 1

  #   pairTotalHeight = pairHeight + (2*pairPadding[0]) + 2*pairBorder

  #   $.each bracket, (bracket_index, bracket_value) ->
  #     if bracket_index == 0
  #       $(".round-#{bracket_value.length*2} li").css('border-top', "1px solid white")
  #       $(".round-#{bracket_value.length*2} li.first").css('border-top', "1px solid black")


  #     marginTop = (Math.pow(2, bracket_index-1)*pairTotalHeight) - pairTotalHeight/2
  #     marginBottom = 2*marginTop
  #     if bracket_index == bracket.length - 1
  #       marginTop = (Math.pow(2, bracket_index-2)*pairTotalHeight) - pairTotalHeight/2
  #       marginBottom = 2*marginTop
  #       $(".winner").css('margin-top', "#{marginTop}px")
  #     else
  #       $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
  #       $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

  #     if bracket_index > 1 && bracket_index != bracket.length - 1
  #       correctedHeight = (Math.pow(2, bracket_index-1)*50)
  #       correctedPadding = (Math.pow(2, bracket_index-1)*10)+(Math.pow(2, bracket_index-1)-1)
  #       if bracket_index-1 > 0
  #         marginTop = Math.pow(2, bracket_index-2)*pairTotalHeight
  #         marginBottom = Math.pow(2, bracket_index-2)*pairTotalHeight*2

  #       $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
  #       $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

  #       $(".round-#{bracket_value.length*2} li").css('height', "#{correctedHeight}px")
  #       $(".round-#{bracket_value.length*2} li").css('padding', "#{correctedPadding}px 35px")

  # renderStandardBracket = (bracket) ->
  #   $('.participants').hide()
  #   output = ""
  #   $.each bracket, (bracket_index, bracket_value) ->
  #     if bracket_index == bracket.length-1
  #       output += "<ul class='round winner'>"
  #     else
  #       output += "<ul class='round round-#{bracket_value.length*2}'>"
  #     $.each bracket_value, (array_index, array_value) ->
  #       if array_index == 0
  #         output_class = " first"
  #       output += "<li class='#{output_class}'>"
  #       output += "<div class='match'>"
  #       if bracket_index == bracket.length - 1
  #         output += "<div> Winner </div>"
  #       else if bracket_value.length == 1
  #         output += "<div> Finals </div>"
  #       else if bracket_value.length == 2
  #         output += "<div> Semi-Finals </div>"
  #       else
  #         output += "<div> Ro#{bracket_value.length*2} Match #{array_index+1} </div>"
  #       if array_value != null
  #         $.each array_value, (user_index, user_value) ->
  #           output += "<div class='slot-view'>#{user_value}</div>"
  #       output += "</div>"
  #       output += "</li>"
  #     output += "</ul>"
  #     $(".bracket").append output
  #     output = ""


  #   pairHeight = 50
  #   pairPadding = [10, 35]
  #   pairWidth = 100
  #   pairBorder = 1

  #   pairTotalHeight = pairHeight + (2*pairPadding[0]) + 2*pairBorder

  #   $.each bracket, (bracket_index, bracket_value) ->
  #     if bracket_index == 0
  #       $(".round-#{bracket_value.length*2} li").css('border-top', "1px solid white")
  #       $(".round-#{bracket_value.length*2} li.first").css('border-top', "1px solid black")


  #     marginTop = (Math.pow(2, bracket_index-1)*pairTotalHeight) - pairTotalHeight/2
  #     marginBottom = 2*marginTop
  #     if bracket_index == bracket.length - 1
  #       marginTop = (Math.pow(2, bracket_index-2)*pairTotalHeight) - pairTotalHeight/2
  #       marginBottom = 2*marginTop
  #       $(".winner").css('margin-top', "#{marginTop}px")
  #     else
  #       $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
  #       $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

  #     if bracket_index > 1 && bracket_index != bracket.length - 1
  #       correctedHeight = (Math.pow(2, bracket_index-1)*50)
  #       correctedPadding = (Math.pow(2, bracket_index-1)*10)+(Math.pow(2, bracket_index-1)-1)
  #       if bracket_index-1 > 0
  #         marginTop = Math.pow(2, bracket_index-2)*pairTotalHeight
  #         marginBottom = Math.pow(2, bracket_index-2)*pairTotalHeight*2

  #       $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
  #       $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

  #       $(".round-#{bracket_value.length*2} li").css('height', "#{correctedHeight}px")
  #       $(".round-#{bracket_value.length*2} li").css('padding', "#{correctedPadding}px 35px")

  # if $('.moderator-status').text() == "true"
  #   renderModeratorBracket(bracketJSON)
  # else if $('.moderator-status').text() == "false"
  #   renderStandardBracket(bracketJSON)


  # $('.bracket').on('click', 'button.slot', () ->
  #   $.ajax(
  #     type: 'POST'
  #     url: '/slots'
  #     dataType: 'json'
  #     data:
  #       position: $(this).data('position')
  #       id: $('.tournament_id').text()
  #     success: (data) ->
  #       console.log data
  #       $('.bracket').empty()
  #       renderModeratorBracket(data.tournament.ordered_bracket)
  #   )
  # )

  # $('.bracket').on('click', '.delete-slot', () ->
  #   debugger
  #   if confirm "Are you sure you want to delete this slot? Round-#{$(this).data('delete-slot')[0]+1} Match-#{$(this).data('delete-slot')[1]+1} #{$(this).data('username')}. This action is NOT reversible."
  #     $.ajax(
  #       type: 'DELETE'
  #       url: '/slots'
  #       dataType: 'json'
  #       data:
  #         destroy: $(this).data('delete-slot')
  #         id: $('.tournament_id').text()
  #       success: (data) ->
  #         console.log data
  #         $('.bracket').empty()
  #         renderModeratorBracket(data.tournament.ordered_bracket)
  #     )
  # )

