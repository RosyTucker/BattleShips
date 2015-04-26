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
canvasList = null

$ ->
  canvasList = $('canvas[id^="board-canvas"]')
  resizeCanvas(aCanvas) for aCanvas in canvasList

handleMove = (data) ->
  console.log(data)
  move = JSON.parse(data)
  $('#xValue' + (move.opponentNumber + 1) % numPlayers).text(move.gridPosition.x)
  $('#yValue' + (move.opponentNumber + 1) % numPlayers).text(move.gridPosition.y)
  colourSquare(move)

resizeCanvas = (canvas) ->
  canvas.height = cellSize * gridSize
  canvas.width = cellSize * gridSize

createDrawingContext = (canvas) ->
  return canvas.getContext '2d'

colourSquare = (move, context) ->
  context = createDrawingContext(canvasList[move.opponentNumber])
  switch move.hitType
    when "miss" then context.fillStyle = '#CC4455'
    when "sunk","hit" then context.fillStyle = '#0e8f47'
    else
  context.fillRect move.gridPosition.x * cellSize, move.gridPosition.y * cellSize, cellSize, cellSize
