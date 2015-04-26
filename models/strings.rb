class Strings

    def self.player_disconnected
      'Player Disconnected'
    end

    def self.spectator_disconnected
      'Spectator Disconnected'
    end

    def self.registered_player number
      'Registered Player: ' + number.to_s
    end

    def self.spectator_added
      'Spectator Connected'
    end

    def self.invalid_message_type
      'Invalid request type or no type given'
    end

    def self.players_turn player_number
      'Player: ' + player_number.to_s + ' will go first'
    end

    def self.invalid_move_made player_number
      'Player: ' + player_number.to_s + ' made an invalid move'
    end

    def self.move_made
      'Move Made'
    end

    def self.game_over
      'Game Over'
    end

end