$(document).on 'ready page:load', ->
  $('#category_id').change ->
    url = $('#form-filter-words').attr('action')
    category_id = $(this). val()
    word_type = $("input[checked='checked']").val()
    $.ajax
      type: 'GET'
      url: url
      data: {word: {category_id: category_id, word_type: word_type}}
      dataType: 'JSON'
      cache: false
      success: (result) ->
        $('.words-rows').html(result.content)
        $('div.pagination').addClass('hidden')
      error: (err) ->
         alert(err)
  $('#form-filter-words').find("input[name='word_type']").on 'change', ->
    $('#form-filter-words').find("input[checked='checked']").removeAttr('checked')
    $(this).attr('checked', true)
    url = $('#form-filter-words').attr('action')
    word_type = $(this).val()
    category_id =  $('#category_id').val()
    $.ajax
      type: 'GET'
      url: url
      data: {word: {category_id: category_id, word_type: word_type}}
      dataType: 'JSON'
      cache: false
      success: (result) ->
        $('.words-rows').html(result.content)
        $('div.pagination').addClass('hidden')
