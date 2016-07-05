$(document).on 'ready page: change', ->
  $('#answer_field input[type=checkbox]').on 'change', ->
    $('#answer_field input[type=checkbox]').not(this).prop('checked',false)
