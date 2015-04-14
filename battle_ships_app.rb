require 'json'
require 'haml'
require 'coffee-script'
require_relative 'model/grid_position'
require_relative 'model/move_result'

class BattleShipsApp < Sinatra::Base

  GRID_SIZE = 12
  @@board = []

  get '/application.js' do
    coffee :application
  end

  get '/' do
    haml :index
  end

post '/setup' do
  puts 'setup'
  unless @setup
    @setup = true
    puts request.ip
    grid_json = JSON.parse(request.body.read)['grid']
    @@board = grid_json.split(',')
  end
end

  post '/makeMove' do
    grid_position = GridPosition.from_json request.body.read
    flattened_position = grid_position.x_pos + (grid_position.y_pos * GRID_SIZE)
    move_result = MoveResult.new grid_position, @@board[flattened_position] == 1
    puts 'pushing'
    settings.channel.push move_result.to_json
  end

end