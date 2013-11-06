$ ->
  setInterval (-> $.makeDbCall()), 50000

$.makeDbCall = ->
  $.ajax({
    url: '/graphs/update'
  }).done (data) ->
  #alert "DOne"
