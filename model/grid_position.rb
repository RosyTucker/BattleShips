class GridPosition

  attr_reader :x_pos, :y_pos

  def initialize x_pos, y_pos
    @x_pos = x_pos
    @y_pos = y_pos
  end

  def self.from_json json
    position_json_object = JSON.parse(json)['move']
    GridPosition.new position_json_object['x'], position_json_object['y']
  end

  def to_json *options
    { :xPos => @x_pos, :yPos => @y_pos }.to_json
  end

end