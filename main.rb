require 'sinatra/base'
# require 'redis'
require 'json'
require 'haml'
require 'coffee-script'
require 'em-websocket'
require 'thin'

module BattleShips

  def self.em_channel
    @em_channel ||= EventMachine::Channel.new
  end

  EM.run do
    class App < Sinatra::Base

      get '/application.js' do
        coffee :application
      end

      get '/' do
        haml :index
      end

      post '/makeMove' do
        BattleShips.em_channel.push request.body.read
        puts 'move'
      end
    end

    puts 'Starting ws'
    EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 9455) do |socket|
      puts 'woo socket'
      socket.onopen do
        @sid = BattleShips.em_channel.subscribe { |msg| socket.send msg }
        # BattleShips.em_channel.push "Woo #{@sid} connected!"
      end

      socket.onmessage do |msg|
        # BattleShips.em_channel.push "Yay <#{@sid}> I recieved your message"
      end

      socket.onclose do
        BattleShips.em_channel.unsubscribe(@sid)
      end
    end
    Thin::Server.start App, '0.0.0.0', 9456
  end
end