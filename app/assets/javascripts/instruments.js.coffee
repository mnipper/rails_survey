jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).siblings('input[type=hidden]').val('1')
    $(this).closest('div.well').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'click', '.move-up', (event) ->
    question = $(this).closest('div.question')
    previousQuestion = question.prevAll('.question').first()
    question.after(previousQuestion)
    event.preventDefault()

  $('form').on 'click', '.move-down', (event) ->
    question = $(this).closest('div.question')
    nextQuestion = question.nextAll('.question').first()
    question.before(nextQuestion)
    event.preventDefault()

  $('form').on 'click', '.show-follow-up-btn', (event) ->
    followUpQuestion = $(this).siblings('div.follow-up-question')
    followUpSelect = followUpQuestion.find('select.question-identifier-list')
    $(this).hide("slow")
    $(this).siblings('div.follow-up-explanation').show("slow")
    followUpQuestion.show("slow")
    $.each(questionIdentifiers().splice(0, questionNumber(followUpQuestion)), (index, item) ->
      followUpSelect.append(new Option(item, item))
    )
    event.preventDefault()

  questionIdentifiers = ->
    identifiers = []
    $('.question-identifier').each ->
      identifiers.push($(this).val())
    identifiers

  questionNumber = (el) ->
    el.closest('div.question').prevAll('.question').size()
