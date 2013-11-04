window.app = {

}

$ ->
  #alert "BEFORE"
  if app.contains '#flash-message'
    #alert "AFTER"
    timeoutDuration = 5000
    setTimeout ->
      $('#flash-message').hide 400
    , timeoutDuration
