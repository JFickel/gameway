# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.bracket_data').hide()
  bracket = JSON.parse($('.bracket_data').text())

  log2 = (val) ->
    Math.log(val) / Math.log 2

  console.log bracket
  $.each bracket, (i, val) ->
    if val.length == 1
      $('.bracket_headers').append "<th>--- Winner ---</th>"
    else if val.length == 2
      $('.bracket_headers').append "<th>--- Finals ---</th>"
    else if val.length == 4
      $('.bracket_headers').append "<th>--- Semi-Finals ---</th>"
    else
      $('.bracket_headers').append "<th>--- Round of #{val.length} ---</th>"

  console.log $('.bracket').children()

  output = ""
  $.each bracket, (bracket_index, bracket_value) ->
    output += "<ul class='round round-#{bracket_value.length*2}'>"
    $.each bracket_value, (array_index, array_value) ->
      if array_index == 0
        output_class = " first"
      output += "<li class='pair#{array_index/2}#{output_class}'>"
      console.log array_value
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
          output += "<div class='slot'>#{user_value}</div>"
      output += "</li>"
    output += "</ul>"
    $(".bracket").append output
    output = ""

  advance = (currentPosition) ->
    return [currentPosition[0] + 1, Math.floor(currentPosition[1]/2)]

  currentUserId = parseInt($('.current_user_id').text())

  $.each bracket, (bracketIndex, bracketValue) ->
    $.each bracketValue, (arrayIndex, arrayValue) ->
      if arrayValue == currentUserId
        window.currentUserPosition = [bracketIndex, arrayIndex]

  console.log currentUserPosition
  console.log currentUserId

  isEven = (n) ->
    return true if n % 2 == 0

  if isEven(currentUserPosition[1])
    window.currentOpponentPosition = [currentUserPosition[0], currentUserPosition[1] + 1]
  else
    window.currentOpponentPosition = [currentUserPosition[0], currentUserPosition[1] - 1]

  currentOpponentId = bracket[currentOpponentPosition[0]][currentOpponentPosition[1]]

  console.log currentOpponentPosition
  console.log currentOpponentId
  console.log advance([0,3])










