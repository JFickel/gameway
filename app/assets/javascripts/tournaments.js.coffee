# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.bracket_data').hide()
  bracket = JSON.parse($('.bracket_data').text())
  console.log bracket

  log2 = (val) ->
    Math.log(val) / Math.log 2

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
          output += "<button class='slot' data-position='[#{bracket_index},#{array_index},#{user_index}]'>#{user_value}</div>"
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
      console.log bracket_index
      correctedPadding = (Math.pow(2, bracket_index-1)*10)+(Math.pow(2, bracket_index-1)-1)
      console.log correctedHeight
      console.log correctedPadding
      if bracket_index-1 > 0
        marginTop = Math.pow(2, bracket_index-2)*pairTotalHeight
        marginBottom = Math.pow(2, bracket_index-2)*pairTotalHeight*2

      # marginTop -= pairTotalHeight/2
      # marginBottom -= pairTotalHeight

      $(".round-#{bracket_value.length*2}").css('margin-top', "#{marginTop}px")
      $(".round-#{bracket_value.length*2} li").css('margin-bottom', "#{marginBottom}px")

      $(".round-#{bracket_value.length*2} li").css('height', "#{correctedHeight}px")
      $(".round-#{bracket_value.length*2} li").css('padding', "#{correctedPadding}px 35px")

  $('.bracket').on('click', 'button.slot', () ->
    $.ajax(
      method: 'PUT'
      url: $('.update_path').text()
      data:
        position: $(this).data('position')
    )
  )


  # advance = (currentPosition) ->
  #   return [currentPosition[0] + 1, Math.floor(currentPosition[1]/2)]

  # currentUserId = parseInt($('.current_user_id').text())

  # $.each bracket, (bracketIndex, bracketValue) ->
  #   $.each bracketValue, (arrayIndex, arrayValue) ->
  #     if arrayValue == currentUserId
  #       window.currentUserPosition = [bracketIndex, arrayIndex]

  # console.log currentUserPosition
  # console.log currentUserId

  # isEven = (n) ->
  #   return true if n % 2 == 0

  # if isEven(currentUserPosition[1])
  #   window.currentOpponentPosition = [currentUserPosition[0], currentUserPosition[1] + 1]
  # else
  #   window.currentOpponentPosition = [currentUserPosition[0], currentUserPosition[1] - 1]

  # currentOpponentId = bracket[currentOpponentPosition[0]][currentOpponentPosition[1]]

  # console.log currentOpponentPosition
  # console.log currentOpponentId
  # console.log advance([0,3])










