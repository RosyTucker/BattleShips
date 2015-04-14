class MoveResult

  attr_reader :grid_position, :is_hit

  def initialize grid_position, is_hit
    @grid_position = grid_position
    @is_hit = is_hit
  end

  def to_json *options
    { :gridPosition => @grid_position, :isHit => @is_hit }.to_json
  end

end