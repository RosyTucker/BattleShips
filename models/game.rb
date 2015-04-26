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
    if @players.length < 2
      player_boats = create_boats data
      new_player = Player.new @players.length, player_boats
      @players[player_id] = new_player
      puts Strings.registered_player new_player.number
      if @players.length == 2
        @ready = true
        notify_players_ready
      end
    end
  end

  def remove id
    remove_player id
    remove_spectator id
  end

  def make_move data, sender_id
    if valid_sender sender_id
      puts Strings.move_made
      opponent = opponent_from_sender sender_id
      grid_position = GridPosition.from_json_object data['move']
      hit_type = check_if_hit opponent, grid_position
      move_result = MoveResult.new opponent.number, grid_position, hit_type
      @player_whose_turn_it_is = opponent.number
      notify_spectators(move_result.to_json)
      if opponent.has_lost
        puts 'game over'
        notify_spectators "game over"
      end
    end
  end

  private

  def valid_sender sender_id
    if @players.has_key?(sender_id) && @ready && @players[sender_id].number == @player_whose_turn_it_is
      return true
    end
    puts Strings.invalid_move_made sender_id
    false
  end

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
        boat.mark_hit grid_position
        if boat.sunk
          return 'sunk'
        end
        return 'hit'
      end
    end
    'miss'
  end

  def notify_players_ready
    first = rand @players.length
    @player_whose_turn_it_is = first
    puts Strings.players_turn @player_whose_turn_it_is
    @players.keys.each do |player_id|
      player_id.send(ready_message(@players[player_id].number == first))
    end
  end

  def ready_message is_first
    is_first.to_s
  end

  def notify_spectators data
    @spectators.each do |spectator|
        spectator.send(data)
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