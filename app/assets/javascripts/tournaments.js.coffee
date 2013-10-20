$ ->
  $('#tournament_starts_on').datepicker
    dateFormat: 'yy-mm-dd'
  $('.bracket_data').hide()
  $('.update_path').hide()
  $('.matches').hide()
  $('.moderator-status').hide()
  bracketJSON = JSON.parse($('.bracket_data').text())

  renderModeratorBracket = (bracket) ->
    $('.participants').hide()
    output = ""
    $.each bracket, (bracket_index, bracket_value) ->
      if bracket_index == bracket.length-1
        output += "<ul class='round winner'>"
      else
        output += "<ul class='round round-#{bracket_value.length*2}'>"
      $.each bracket_value, (array_index, array_value) ->
        if array_index == 0
          output_class = " first"
        output += "<li class='#{output_class}'>"
        output += "<div class='match'>"
        if bracket_index == bracket.length - 1
          output += "<div> Winner </div>"
        else if bracket_value.length == 1
          output += "<div> Finals </div>"
        else if bracket_value.length == 2
          output += "<div> Semi-Finals </div>"
        else
          output += "<div> Ro#{bracket_value.length*2} Match #{array_index+1} </div>"
        if array_value != null
          $.each array_value, (user_index, user_value) ->
            output += "<a class='delete-slot' data-delete-slot='[#{bracket_index},#{array_index},#{user_index}]' data-username='#{user_value}'>x</a><button class='slot' data-position='[#{bracket_index},#{array_index},#{user_index}]'>#{user_value}</div>"
        output += "</div>"
        output += "</li>"
      output += "</ul>"
      $(".bracket").append output
      output = ""


    pairHeight = 50
    pairPadding = [10, 35]
    pairWidth = 100
    pairBorder = 1

    pairTotalHeight = pairHeight + (2*pairPadding[0]) + 2*pairBorder

    $.each bracket, (bracket_index, bracket_value) ->
      if bracket_index == 0
        $(".round-#{bracket_value.length*2} li").css('border-top', "1px solid white")
        $(".round-#{bracket_value.length*2} li.first").css('border-top', "1px solid black")


      marginTop = (Math.pow(2, bracket_index-1)*pairTotalHeight) - pairTotalHeight/2
      marginBottom = 2*marginTop
      if bracket_index == bracket.length - 1
        marginTop = (Math.pow(2, bracket_index-2)*pairTotalHeight) - pairTotalHeight/2
        marginBottom = 2*marginTop
        $(".winner").css('margin-top', "#{marginTop}px")
      else
        $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
        $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

      if bracket_index > 1 && bracket_index != bracket.length - 1
        correctedHeight = (Math.pow(2, bracket_index-1)*50)
        correctedPadding = (Math.pow(2, bracket_index-1)*10)+(Math.pow(2, bracket_index-1)-1)
        if bracket_index-1 > 0
          marginTop = Math.pow(2, bracket_index-2)*pairTotalHeight
          marginBottom = Math.pow(2, bracket_index-2)*pairTotalHeight*2

        $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
        $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

        $(".round-#{bracket_value.length*2} li").css('height', "#{correctedHeight}px")
        $(".round-#{bracket_value.length*2} li").css('padding', "#{correctedPadding}px 35px")

  renderStandardBracket = (bracket) ->
    $('.participants').hide()
    output = ""
    $.each bracket, (bracket_index, bracket_value) ->
      if bracket_index == bracket.length-1
        output += "<ul class='round winner'>"
      else
        output += "<ul class='round round-#{bracket_value.length*2}'>"
      $.each bracket_value, (array_index, array_value) ->
        if array_index == 0
          output_class = " first"
        output += "<li class='#{output_class}'>"
        output += "<div class='match'>"
        if bracket_index == bracket.length - 1
          output += "<div> Winner </div>"
        else if bracket_value.length == 1
          output += "<div> Finals </div>"
        else if bracket_value.length == 2
          output += "<div> Semi-Finals </div>"
        else
          output += "<div> Ro#{bracket_value.length*2} Match #{array_index+1} </div>"
        if array_value != null
          $.each array_value, (user_index, user_value) ->
            output += "<div class='slot-view'>#{user_value}</div>"
        output += "</div>"
        output += "</li>"
      output += "</ul>"
      $(".bracket").append output
      output = ""


    pairHeight = 50
    pairPadding = [10, 35]
    pairWidth = 100
    pairBorder = 1

    pairTotalHeight = pairHeight + (2*pairPadding[0]) + 2*pairBorder

    $.each bracket, (bracket_index, bracket_value) ->
      if bracket_index == 0
        $(".round-#{bracket_value.length*2} li").css('border-top', "1px solid white")
        $(".round-#{bracket_value.length*2} li.first").css('border-top', "1px solid black")


      marginTop = (Math.pow(2, bracket_index-1)*pairTotalHeight) - pairTotalHeight/2
      marginBottom = 2*marginTop
      if bracket_index == bracket.length - 1
        marginTop = (Math.pow(2, bracket_index-2)*pairTotalHeight) - pairTotalHeight/2
        marginBottom = 2*marginTop
        $(".winner").css('margin-top', "#{marginTop}px")
      else
        $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
        $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

      if bracket_index > 1 && bracket_index != bracket.length - 1
        correctedHeight = (Math.pow(2, bracket_index-1)*50)
        correctedPadding = (Math.pow(2, bracket_index-1)*10)+(Math.pow(2, bracket_index-1)-1)
        if bracket_index-1 > 0
          marginTop = Math.pow(2, bracket_index-2)*pairTotalHeight
          marginBottom = Math.pow(2, bracket_index-2)*pairTotalHeight*2

        $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
        $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

        $(".round-#{bracket_value.length*2} li").css('height', "#{correctedHeight}px")
        $(".round-#{bracket_value.length*2} li").css('padding', "#{correctedPadding}px 35px")

  if $('.moderator-status').text()
    renderModeratorBracket(bracketJSON)
  else
    renderStandardBracket(bracketJSON)

  $('.bracket').on('click', 'button.slot', () ->
    $.ajax(
      type: 'PUT'
      url: $('.update_path').text()
      dataType: 'json'
      data:
        position: $(this).data('position')
      success: (data) ->
        $('.bracket').empty()
        renderModeratorBracket(data)
    )
  )

  $('.bracket').on('click', '.delete-slot', () ->
    if confirm "Are you sure you want to delete this slot? Round-#{$(this).data('delete-slot')[0]+1} Match-#{$(this).data('destroy')[1]+1} #{$(this).data('username')}. This action is NOT reversible."
      $.ajax(
        type: 'PUT'
        url: $('.update_path').text()
        dataType: 'json'
        data:
          destroy: $(this).data('destroy')
        success: (data) ->
          console.log data
          $('.bracket').empty()
          renderModeratorBracket(data)
      )
  )


