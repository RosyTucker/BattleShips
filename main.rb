require 'sinatra/base'
require_relative 'model/socket'
require_relative 'battle_ships_app'

module Main

  EM.run do
    channel = EventMachine::Channel.new
    BattleShipsApp.set :channel, channel
    socket = MySocket.new channel
    socket.start 9455
    Thin::Server.start '0.0.0.0', 9456, BattleShipsApp
  end

end