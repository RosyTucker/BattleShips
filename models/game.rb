require_relative 'strings'
require_relative '../models/boat'
require_relative '../models/player'
require_relative '../models/grid_position'
require_relative '../models/move_result'
require_relative '../models/strings'

class Game

  def initialize
    @players = Hash.new
    @spectators = []
  end

  def add_spectator spectator_id
    @spectators << spectator_id
    puts Strings.spectator_added
  end

  def add_player data, player_id
    player_boats = create_boats data
    new_player = Player.new @players.length, player_boats
    @players[player_id] = new_player
    puts Strings.registered_player new_player.number
  end

  def remove id
    remove_player id
    remove_spectator id
  end

  def make_move data, sender_id
    opponent = opponent_from_sender sender_id
    grid_position = GridPosition.from_json_object data['move']
    is_hit = check_if_hit opponent, grid_position
    move_result = MoveResult.new opponent.number, grid_position, is_hit
    notify_spectators(sender_id, move_result.to_json)
  end

  private

  def remove_spectator id
    if @spectators.include? id
      @spectators.delete id
      puts Strings.spectator_disconnected
    end
  end

  def remove_player id
    if @players.has_key? id
      @players.delete id
      puts Strings.player_disconnected
    end
  end

  def create_boats data
    boats_array = []
    data['boats'].each do |boat|
      boats_array << Boat.from_json_object(boat)
    end
    boats_array
  end

  def check_if_hit opponent, grid_position
    opponent.boats.each do |boat|
      if boat.contains grid_position
        return true
      end
    end
    false
  end

  def notify_spectators sender, data
    @spectators.each do |spectator|
      if spectator != sender
        spectator.send(data)
      end
    end
  end

  def opponent_from_sender sender
    player = nil
    @players.keys.each do |key|
      player = @players[key] if key != sender
    end
    player
  end
end