$(document).ready ->
  $('form#edit_starcraft2_account_1').on('ajax:success', (evnt, data, status, xhr) ->
    console.log "SUCCESS"
    console.log evnt
    console.log data
    # console.log status
    console.log xhr
  )


  $('form#edit_starcraft2_account_1').on('ajax:error', (evnt, xhr, status, error) ->
    console.log "ERROR"
    console.log status
    console.log xhr
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
