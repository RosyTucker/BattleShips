require 'thin'
require 'em-websocket'

class MySocket

  def initialize channel
    @channel = channel
  end

  def start port
    start_socket port
  end

  def start_socket port
    EventMachine::WebSocket.start(:host => '0.0.0.0', :port => port) do |socket|
      socket.onopen do
        @sid = @channel.subscribe { |msg| socket.send msg }
      end

      socket.onclose do
        @channel.unsubscribe(@sid)
      end
    end
  end

end
