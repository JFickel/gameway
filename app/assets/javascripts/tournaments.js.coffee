$ ->
  console.log JSON.parse($('.bracket_data').text())
  $('#tournament_start_date').datepicker
    dateFormat: 'yy-mm-dd'
  $('.bracket_data').hide()
  $('.update_path').hide()
  $('.tournament_id').hide()
  $('.matches').hide()
  $('.moderator-status').hide()

  $('.tournament-delete-btn').click () ->
    return confirm("Are you sure you want to delete this tournament?")

  if $('.bracket_data').text() != ""
    bracketJSON = JSON.parse($('.bracket_data').text())

  class BracketView
    constructor: (options) ->
      {@moderatorStatus, @matchHeight, @matchPadding, @matchWidth, @matchBorder} = options

    determineClassRound: (round_index, round, self) ->
      if round_index == self.bracket.length-1
        return "<ul class='round winner'>"
      else
        return "<ul class='round round-#{round.length*2}'>"

    renderBracket: (@bracket) ->
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
            $.each match, (user_index, user) ->
              if self.moderatorStatus is "true"
                output += "<div class='slot'><a class='delete-slot-btn' data-delete-slot='[#{round_index},#{match_index},#{user_index}]' data-username='#{user}'>x</a>"
                output += "<button class='advance-slot' data-position='[#{round_index},#{match_index},#{user_index}]'>#{user}</button></div>"
              else if self.moderatorStatus is "false"
                output += "<div class='slot'>#{user}</div>"
          output += "</div></li>"
        output += "</ul>"
        $(".bracket").append output
        output = ""
      @setStyles()

    determineHeader: (round_index, round, match_index, self) ->
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
          $(".round-#{round.length*2} li").css('border-top', "0px solid white")
          $(".round-#{round.length*2} li").css('padding-top', "11px")
          $(".round-#{round.length*2} li:first-child").css('border-top', "1px solid black")

        marginTop = (Math.pow(2, round_index-1)*matchTotalHeight) - matchTotalHeight/2
        marginBottom = 2*marginTop
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
          $(".round-#{round.length*2} li").css('padding', "#{((correctedHeight-70)/2)+correctedPadding}px 35px")

  bracketView = new BracketView
    moderatorStatus: $('.moderator-status').text()
    matchHeight: 50
    matchPadding: [10, 35]
    matchWidth: 100
    matchBorder: 1

  bracketView.renderBracket(bracketJSON)

  $('.slot').hover(
    () ->
      $(this).addClass("highlighted")

      username = $(this).find(".advance-slot").text()
      $(".slot .advance-slot:contains(#{username})").addClass("highlighted")

      $.each($(".slot .advance-slot:contains(#{username})"), (ind, val) ->
        console.log val
      )

    () ->
      $(this).removeClass("highlighted")
      username = $(this).find(".advance-slot").text()
      $(".slot .advance-slot:contains(#{username})").removeClass("highlighted")

  )

  $('.bracket').on('click', 'button.advance-slot', () ->
    $.ajax(
      type: 'POST'
      url: '/slots'
      dataType: 'json'
      data:
        position: $(this).data('position')
        id: $('.tournament_id').text()
      success: (data) ->
        $('.bracket').empty()
        bracketView.renderBracket(data.tournament.ordered_bracket)
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
          bracketView.renderBracket(data.tournament.ordered_bracket)
      )
  )











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

