# require 'json'
require 'haml'
require 'coffee-script'
require 'sinatra/base'
# require_relative 'controllers/socket'
# require_relative 'models/grid_position'
# require_relative 'models/move_result'
# require_relative 'models/boat'
# require_relative 'models/player'

class BattleShipsApp < Sinatra::Base
  # set :port, 9496
  # set :bind, '0.0.0.0'

  get '/application.js' do
    coffee :application
  end

  get '/' do
    haml :index
  end
end
  #
  # GRID_SIZE = 10
  # @@players = Hash.new
  #
  # get '/register' do
  #   puts 'register'
  # end
  #
  # post '/setup' do
  #   puts 'setup'
  #   boats_array = []
  #   boats = JSON.parse(request.body.read)['boats']
  #   boats.each do |boat_json_object|
  #     boats_array << Boat.from_json_object(boat_json_object)
  #   end
  #   @@players[request.ip] = Player.new(@@players.length, boats_array)
  #   while(!ready) do
  #     sleep(500)
  #   end
  #   'Ready'
  # end
  #
  # get '/ready' do
  #   puts 'ready'
  #   puts @@players.count
  #   response = 'Not Ready'
  #   if ready
  #     response = "Ready: #{@@players[request.ip].number}"
  #   end
  #   response
  # end
  #
  # post '/makeMove' do
  #   if ready
  #     @@players.keys.each do |ip|
  #       if ip != request.ip
  #         puts 'makeMove'
  #         opponent = @@players[ip]
  #         grid_position = GridPosition.from_json_object JSON.parse(request.body.read)['move']
  #         is_hit = BattleShipsApp.check_if_hit opponent, grid_position
  #         move_result = MoveResult.new opponent.number, grid_position, is_hit
  #         settings.channel.push move_result.to_json
  #         move_result.to_json
  #       end
  #     end
  #   end
  # end
  #
  # private
  # def self.check_if_hit opponent, grid_position
  #   opponent.boats.each do |boat|
  #     if boat.contains grid_position
  #       return true
  #     end
  #   end
  #   false
  # end
  #
  # def ready
  #   puts @@players.length
  #   @@players.length == 2
  # end
# end