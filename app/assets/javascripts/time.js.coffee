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

  class Person
    constructor: (@name) ->

    assemble: ->
      console.log "assemblin' c; #{@name}"

    spoogetuh: ->
      @assemble()
      console.log "spooked ya"
      console.log this

  bobbeh = new Person "bobby"
  bobbeh.spoogetuh()

  class Bitch
    constructor: (options) ->
      {@sex, @race, @height} = options

  slut = new Bitch
    sex: 'male'
    race: 'tauren'
    height: "4'5"


  console.log slut.height
