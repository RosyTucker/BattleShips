require 'em-websocket'
require_relative '../models/grid_position'
require_relative '../models/move_result'
require_relative '../models/player'
require_relative '../models/boat'

class MySocket

  def start port

    @players = Hash.new
    @clients = []

    EM::WebSocket.start(:host => "0.0.0.0", :port => port) do |ws|
      ws.onopen do
        puts "Client Connected"
        @clients << ws
      end

      ws.onclose do
        puts "Connection closed"
      end

      ws.onmessage  do |msg|
        msgObj = JSON.parse(msg)
        puts "Received message: #{msgObj['type']}"
        case msgObj['type']
          when 'register'
            register msgObj['data'], ws
          when 'move'
            puts 'move'
            move msgObj['data'], ws
          else
            puts 'Invalid request'
        end
      end
    end
  end

  private

  def move data, sender
    grid_position = GridPosition.from_json_object data['move']
    is_hit = check_if_hit #opponent, grid_position
    move_result = MoveResult.new 0, grid_position, is_hit
    @clients.each do |client|
      if(client != sender)
        client.send(move_result.to_json)
      end
    end
  end

  def register data, ws
    boats_array = []
    puts data
    boats = data['boats']
    boats.each do |boat_json_object|
      boats_array << Boat.from_json_object(boat_json_object)
    end
    @players[ws] = Player.new @clients.length, boats_array
    puts @players[ws].boats
  end

  def check_if_hit #opponent, grid_position
    true
    # opponent.boats.each do |boat|
    #   if boat.contains grid_position
    #     return true
    #   end
    # end
    # false
  end
end
