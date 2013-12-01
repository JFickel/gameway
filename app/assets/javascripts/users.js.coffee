$(document).ready ->
  $('form.new_starcraft2_account, form.edit_starcraft2_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.new_starcraft2_account, form.edit_starcraft2_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong adding your Starcraft 2 Account</div>")
  )



  $('form.new_lol_account, form.edit_lol_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.new_lol_account, form.edit_lol_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong adding your Starcraft 2 Account</div>")
  )



  $('form.new_twitch_account, form.edit_twitch_account').on('ajax:success', (evnt, data, status, xhr) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>#{data.message}</div>")
  )

  $('form.new_twitch_account, form.edit_twitch_account').on('ajax:error', (evnt, xhr, status, error) ->
    $('.link-accounts .flash-messages').empty()
    $('.link-accounts .flash-messages').append("<div class='link-account-flash'>Something went wrong adding your Starcraft 2 Account</div>")
  )

# all of this would be fixed with ember.js
# the problem is that the new form needs to be turned into an edit form after the ajax event fires, but I don't really feel like doing that right now


# $('#account_settings').on('ajax:error', function(event, xhr, status) {
#   // insert the failure message inside the "#account_settings" element
#   $(this).append(xhr.responseText)
# });

  # $('.edit_starcraft2_account').on('ajax:complete', (evnt, xhr, status) ->
  #   console.log evnt
  #   # console.log status
  #   console.log xhr
  # )
