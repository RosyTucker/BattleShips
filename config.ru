require 'sinatra'
require 'haml'
require 'sass/plugin/rack'
require './main.rb'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

# run BattleShips::App