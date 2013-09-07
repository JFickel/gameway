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


  $.each bracket, (bracket_index, bracket_value) ->
    $('.bracket').append("<div class='round #{bracket_value.length}'></div>")
    $.each bracket_value, (array_index, array_value) ->
      $(".round.#{bracket_value.length}").append "<div class=slot>#{array_value}</div>"










