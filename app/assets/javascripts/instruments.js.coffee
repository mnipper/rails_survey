jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('div[class="well"]').hide()
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'click', '.move-up', (event) ->
    question = $(this).closest('div.question')
    previousQuestion = question.prev('.question')
    if previousQuestion.hasClass('question')
      question.after(previousQuestion)
    event.preventDefault()

  $('form').on 'click', '.move-down', (event) ->
    question = $(this).closest('div.question')
    nextQuestion = question.next('.question')
    if nextQuestion.hasClass('question')
      question.before(nextQuestion)
    event.preventDefault()
