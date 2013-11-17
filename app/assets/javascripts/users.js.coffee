# $('.new_starcraft2_account').on('ajax:success', (data, status, xhr) ->
#   console.log data
#   console.log status
#   console.log xhr
#   # $('#starcraft2_account_url').text("")
# )

# # $('.new_starcraft2_account').on('ajax:complete', (xhr, status) ->
# #   console.log data
# #   console.log status
# #   console.log xhr
# #   # $('#starcraft2_account_url').text("")
# # )
# # $(document).ready ->
# #   $("#new_post").on("ajax:success", (e, data, status, xhr) ->
# #     $("#new_post").append xhr.responseText
# #   ).bind "ajax:error", (e, xhr, status, error) ->
# #     $("#new_post").append "<p>ERROR</p>"

$(document).ready ->
  $('.edit_starcraft2_account').on('ajax:success', (event, data, status, xhr) ->
    console.log event
    console.log data
    console.log status
    console.log xhr
  )

  $('.edit_starcraft2_account').on('ajax:complete', (xhr, status) ->
    console.log status
    console.log xhr
  )


  # $('.edit_starcraft2_account').on('ajax:send', (xhr) ->
  #   console.log xhr
  # )

  # $('.edit_starcraft2_account').on('ajax:before', () ->
  #   console.log "IT WENT IT WENT IT WENT"
  # )
