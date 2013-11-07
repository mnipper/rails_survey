$ ->
  console.log "Called"
  setInterval (-> $.makeDbCall()), 50000

  $.makeDbCall = ->
    $.ajax({
      url: '/graphs/update'
    }).done (data) ->

  $("#bar-charts").click (e) ->
    console.log "bar-chart"
    $.ajax({
      url: '/bars'
    }).done (data) ->
      console.log "done bars"

  $("#realtime-charts").click (e) ->
    $.ajax({
      url: '/realtime'
    }).done (data) ->
      console.log "done real"
