WEB_SOCKET_URL = 'ws://' + window.location.hostname + ':' + (window.location.port - 1)
console.log(WEB_SOCKET_URL)
socket = new WebSocket WEB_SOCKET_URL
socket.onopen = () ->
  console.log("Open")
socket.onmessage = (e) ->
  handleMove e.data
socket.onclose = () -> console.log 'socket closed'
cellSize = 40
gridSize = 10
numPlayers = 2
canvas = null

$ ->
  canvas = $('#board-canvas')[0]
  resizeCanvas(canvas)

handleMove = (data) ->
  console.log(data)
  move = JSON.parse(data)
  $('#xValue' + move.opponentNumber).text(move.gridPosition.xPos)
  $('#yValue' + move.opponentNumber).text(move.gridPosition.yPos)
  colourSquare(move)

resizeCanvas = (canvas) ->
  console.log('resizing: ' + canvas)
  canvas.height = cellSize * gridSize
  canvas.width = cellSize * gridSize * numPlayers

createDrawingContext = (canvas) ->
  return canvas.getContext '2d'

colourSquare = (move, context) ->
  context = createDrawingContext(canvas)
  console.log(move)
  context.fillStyle = if move.isHit then '#0e8f47' else '#CC4455'
  xPos = move.gridPosition.xPos + gridSize * move.opponentNumber
  context.fillRect xPos * cellSize, move.gridPosition.yPos * cellSize, cellSize, cellSize
