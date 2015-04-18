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

    def self.game_not_reader player_number
      'Game not ready, player: ' + player_number.to_s + ' is being naughty'
    end

    def self.not_players_turn  player_number
      'It\'s not your turn player: ' + player_number.to_s
    end

    def self.players_turn player_number
      'Player: ' + player_number.to_s + ' will go first'
    end

end