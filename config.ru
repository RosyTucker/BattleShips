require 'sinatra'
require 'haml'
require 'thin'
require 'sass/plugin/rack'
require './battle_ships_app'
require './controllers/socket'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

EM.run do
  socket = MySocket.new
  socket.start 2999
  Thin::Server.start BattleShipsApp
end