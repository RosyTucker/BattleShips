class MoveResult

  def initialize opponent_number, grid_position, hit_type
    @opponent_number = opponent_number
    @grid_position = grid_position
    @hit_type = hit_type
  end

  def to_json *options
    { :type => 'moveResult', :data => { :opponentNumber => @opponent_number, :gridPosition => @grid_position, :hitType => @hit_type }}.to_json
  end

end