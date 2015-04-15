require 'json'
require 'haml'
require 'coffee-script'
require_relative 'model/grid_position'
require_relative 'model/move_result'
require_relative 'model/boat'

class BattleShipsApp < Sinatra::Base

  GRID_SIZE = 10
  @@boats = []
  @@setup = false

  get '/application.js' do
    coffee :application
  end

  get '/' do
    haml :index
  end

  post '/setup' do
    puts 'setup'
    @@boats = []
    boats = JSON.parse(request.body.read)['boats']
    boats.each do |boat_json_object|
      @@boats << Boat.from_json_object(boat_json_object)
    end
    puts @@boats
  end

  post '/makeMove' do
    grid_position = GridPosition.from_json_object JSON.parse(request.body.read)['move']
    is_hit = BattleShipsApp.check_if_hit grid_position
    move_result = MoveResult.new grid_position, is_hit
    puts 'pushing'
    settings.channel.push move_result.to_json
  end

  private
  def self.check_if_hit grid_position
    @@boats.each do |boat|
      if boat.contains grid_position
        return true
      end
    end
    false
  end
end