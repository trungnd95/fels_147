$(document).on 'ready page:change', ->
  $('div.alert-danger').delay(3000).slideUp()
  $('div.alert-success').delay(3000).slideUp()
  cancel_function = ->
    window.history.back()

  $('.space').find('ul').find('li').on 'click', ->
    $(this).find('a').css('background', 'none')
  $('#admin_users_m').dataTable
    'paging':true,
    'lengthMenu': [[5,10,15,-1],[5,10,15,'All']]
  $('#admin_words_m').dataTable
    retrieve: true,
    paging: false
    'lengthMenu': [[5,10,15,-1],[5,10,15,'All']]
  $('#table_users').dataTable
    retrieve: true,
    paging: false
    'lengthMenu': [[5,10,15,-1],[5,10,15,'All']]
  $('#table_category_users').dataTable
    retrieve: true
    paging: false
  $('.field_with_errors:has(input[type=checkbox])').css('width', '0%')
  $('.panel:odd').append('<div class="clearfix"></div>')
