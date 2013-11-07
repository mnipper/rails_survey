###
window.app = {

}

$ ->
  if app.contains '#flash-message'
    timeoutDuration = 5000
    setTimeout ->
      $('#flash-message').hide 400
    , timeoutDuration
###
