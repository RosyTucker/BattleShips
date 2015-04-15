require_relative 'grid_position'

class Boat

  attr_reader :start_position
  attr_reader :position

  def initialize start_position, end_position
    @start_position = start_position
    @end_position = end_position
  end

  def self.from_json_object json_object
    start_coords = json_object['s'].split(',')
    end_coords = json_object['e'].split(',')
    start_position = GridPosition.new start_coords[0].to_i, start_coords[1].to_i
    end_position = GridPosition.new end_coords[0].to_i, end_coords[1].to_i
    Boat.new start_position, end_position
  end

  def contains grid_position
    if contains_x(grid_position) && contains_y(grid_position)
      true
    else
      false
    end
  end

  private
  def contains_x(grid_position)
    (grid_position.x_pos <= @end_position.x_pos && grid_position.x_pos >= @start_position.x_pos) ||
        (grid_position.x_pos >= @end_position.x_pos && grid_position.x_pos <= @start_position.x_pos)
    end

  def contains_y(grid_position)
    (grid_position.y_pos <= @end_position.y_pos && grid_position.y_pos >= @start_position.y_pos) ||
    (grid_position.y_pos >= @end_position.y_pos && grid_position.y_pos <= @start_position.y_pos)
  end

end