$ ->
  $('.time_zone').set_timezone()

  $.ajax(
    type: 'POST'
    url: '/time_zones'
    dataType: 'json'
    data:
      time_zone: $('.time_zone').val()
    success: (data) ->
      if data.timezone is false
        location.reload()
  )
