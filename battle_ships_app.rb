require 'haml'
require 'coffee-script'
require 'sinatra/base'

class BattleShipsApp < Sinatra::Base

  get '/application.js' do
    coffee :application
  end

  get '/' do
    haml :index
  end
end