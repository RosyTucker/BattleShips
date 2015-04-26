require_relative 'grid_position'
class Boat

  def initialize start_position, length, direction
    @start_position = start_position
    @length = length
    @direction = direction
    @hits = Array.new(@length)
  end

  def sunk
   @hits.each do |hit|
     unless hit
       return false
     end
   end
   true
  end

  def mark_hit grid_position
    case @direction
      when 'N'
        @hits[@start_position.y_pos - grid_position.y_pos] = true
      when 'E'
        @hits[grid_position.x_pos - @start_position.x_pos] = true
      when 'S'
        @hits[grid_position.y_pos - @start_position.y_pos] = true
      when 'W'
        @hits[@start_position.x_pos - grid_position.x_pos] = true
      else
    end
  end

  def contains grid_position
    case @direction
      when 'E'
        (grid_position.x_pos >= @start_position.x_pos && grid_position.x_pos < @start_position.x_pos + @length) && grid_position.y_pos == @start_position.y_pos
      when 'W'
        (grid_position.x_pos <= @start_position.x_pos && grid_position.x_pos > @start_position.x_pos - @length) && grid_position.y_pos == @start_position.y_pos
      when 'N'
        (grid_position.y_pos <= @start_position.y_pos && grid_position.y_pos > @start_position.y_pos - @length) && grid_position.x_pos == @start_position.x_pos
      when 'S'
        (grid_position.y_pos >= @start_position.y_pos && grid_position.y_pos < @start_position.y_pos + @length) && grid_position.x_pos == @start_position.x_pos
      else
        false
    end
  end

  def self.from_json_object json_object
    start_coords = json_object['start'].split(',')
    length = json_object['length']
    direction = json_object['direction']
    start_position = GridPosition.new start_coords[0].to_i, start_coords[1].to_i
    Boat.new start_position, length, direction
  end

end
