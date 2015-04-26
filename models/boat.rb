require_relative 'grid_position'
class Boat

  def initialize start_position, length, direction
    @start_position = start_position
    @length = length
    @direction = direction
  end

  def self.from_json_object json_object
    start_coords = json_object['start'].split(',')
    length = json_object['length']
    direction = json_object['direction']
    start_position = GridPosition.new start_coords[0].to_i, start_coords[1].to_i
    Boat.new start_position, length, direction
  end

  def contains grid_position
    case @direction
      when 'E'
        (grid_position.x_pos >= @start_position.x_pos && grid_position.x_pos < @start_position.x_pos + @length)
      when 'W'
        (grid_position.x_pos <= @start_position.x_pos && grid_position.x_pos > @start_position.x_pos - @length)
      when 'N'
        (grid_position.y_pos <= @start_position.y_pos && grid_position.y_pos > @start_position.y_pos - @length)
      when 'S'
        (grid_position.y_pos >= @start_position.y_pos && grid_position.y_pos < @start_position.y_pos + @length)
      else
        false
    end
  end
end
