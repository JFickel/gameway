$(document).ready ->
  $('form.new_starcraft2_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.new_starcraft2_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong adding your Starcraft 2 Account</div>")
  )


  $('form.edit_starcraft2_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.edit_starcraft2_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong updating your Starcraft 2 Account</div>")
  )



  $('form.new_lol_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.new_lol_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong adding your Starcraft 2 Account</div>")
  )


  $('form.edit_lol_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.edit_lol_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong updating your Starcraft 2 Account</div>")
  )




  $('form.new_twitch_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.new_twitch_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong adding your Starcraft 2 Account</div>")
  )


  $('form.edit_twitch_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.edit_twitch_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong updating your Starcraft 2 Account</div>")
  )




# $('#account_settings').on('ajax:error', function(event, xhr, status) {
#   // insert the failure message inside the "#account_settings" element
#   $(this).append(xhr.responseText)
# });

  # $('.edit_starcraft2_account').on('ajax:complete', (evnt, xhr, status) ->
  #   console.log evnt
  #   # console.log status
  #   console.log xhr
  # )
