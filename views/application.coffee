WEB_SOCKET_URL = 'ws://' + window.location.hostname + ':' + (window.location.port - 1)
console.log(WEB_SOCKET_URL)
socket = new WebSocket WEB_SOCKET_URL
socket.onopen = () ->
  socket.send 'hello'
socket.onmessage = (e) ->
  handleMove e.data
socket.onclose = () -> console.log 'socket closed'
cellSize = 40
numberOfRows = 12
numberOfColumns = 12
canvas = null

$ ->
  canvas = $('#board-canvas')[0]
  resizeCanvas(canvas)

handleMove = (data) ->
  move = JSON.parse(data).move
  $('#xValue').text(move.x)
  $('#yValue').text(move.y)
  colourSquare(move)

resizeCanvas = (canvas) ->
  console.log('resizing: ' + canvas)
  canvas.height = cellSize * numberOfRows
  canvas.width = cellSize * numberOfColumns

createDrawingContext = (canvas) ->
  return canvas.getContext '2d'

colourSquare = (move, context) ->
  context = createDrawingContext(canvas)
  context.fillStyle = '#C02942'
  context.fillRect move.x * cellSize, move.y*cellSize, cellSize, cellSize
