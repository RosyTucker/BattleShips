require 'em-websocket'
require_relative '../models/grid_position'
require_relative '../models/move_result'
require_relative '../models/player'
require_relative '../models/boat'
require_relative '../models/game'
require_relative '../models/message_type'
class MySocket

  def initialize
    @game = Game.new
  end

  def start port
    EM::WebSocket.start(:host => "0.0.0.0", :port => port) do |ws|
      ws.onopen do connect_client ws end

      ws.onclose do @game.remove ws end

      ws.onmessage  do |msg| direct_message JSON.parse(msg), ws end
    end
  end

  private

  def direct_message message_json_object, sender_id
    case message_json_object['type']

      when MessageType.register
        @game.add_player message_json_object['data'], sender_id

      when MessageType.move
        @game.make_move message_json_object['data'], sender_id

      else
        puts Strings.invalid_message_type

    end
  end

  def connect_client client
    @game.add_spectator client
  end

end
