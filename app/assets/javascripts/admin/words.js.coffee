jQuery ->
  $('.add_fields').addClass('btn btn-primary')
  $('.add_fields').css('margin-bottom':'20px','float':'right')
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    console.log()
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
