$ ->
  console.log "Called"
  setInterval (-> $.makeDbCall()), 50000

  $.makeDbCall = ->
    $.ajax({
      url: '/graphs/update'
    }).done (data) ->

  ###$("#bar-charts").click (e) ->
    e.stopPropagation()
    console.log "bar-chart"
    $.getScript "/app/views/graphs/bar.js"
    console.log "called bar chart script"

  $("#realtime-charts").click (e) ->
    console.log "realtime-chart"
    $.ajax({
      url: '/realtime'
    }).done (data) ->
      console.log "done real"###
