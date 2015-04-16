class MoveResult

  def initialize opponent_number, grid_position, is_hit
    @opponent_number = opponent_number
    @grid_position = grid_position
    @is_hit = is_hit
  end

  def to_json *options
    { :opponentNumber => @opponent_number, :gridPosition => @grid_position, :isHit => @is_hit }.to_json
  end

end