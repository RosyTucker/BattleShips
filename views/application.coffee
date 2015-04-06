WEB_SOCKET_URL = 'ws://' + window.location.hostname + ':' + (window.location.port - 1)
console.log(WEB_SOCKET_URL)

socket = new WebSocket WEB_SOCKET_URL
socket.onopen = () ->
  console.log 'opened: ' + WEB_SOCKET_URL
  socket.send('hello')
socket.onmessage = (e) ->
  console.log 'Data arrived:' + e.data
  move = JSON.parse(e.data).move
  $('#xValue').text(move.x)
  $('#yValue').text(move.y)
socket.onclose = () -> console.log 'socket closed'
##socket.close(); //easy!

