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

end