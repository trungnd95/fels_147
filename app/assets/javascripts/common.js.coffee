$(document).on 'ready page:change', ->
  $('div.alert-danger').delay(1000).slideUp()
  $('div.alert-success').delay(1000).slideUp()
  cancel_function = ->
    window.history.back()

