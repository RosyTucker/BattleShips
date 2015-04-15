require_relative 'spec_helper'

describe 'Contains' do

  it 'should contain a grid position whose x co-ordinate is between start and end when start is less than end' do
    start_position = GridPosition.new 5, 10
    end_position = GridPosition.new 10, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 7, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be true
  end

  it 'should contain a grid position whose x co-ordinate is between start and end when start is greater than end' do
    start_position = GridPosition.new 10, 10
    end_position = GridPosition.new 5, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 7, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be true
  end

  it 'should not contain a grid position whose x co-ordinate is greater than end when end is greater than start' do
    start_position = GridPosition.new 5, 10
    end_position = GridPosition.new 10, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 11, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be false
  end

  it 'should not contain a grid position whose x co-ordinate is greater than start when start is greater than end' do
    start_position = GridPosition.new 8, 10
    end_position = GridPosition.new 3, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 9, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be false
  end

  it 'should not contain a grid position whose x co-ordinate is less than start when start is less than end' do
    start_position = GridPosition.new 4, 10
    end_position = GridPosition.new 7, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 3, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be false
  end

  it 'should not contain a grid position whose x co-ordinate is less than end when end is less than start' do
    start_position = GridPosition.new 5, 10
    end_position = GridPosition.new 3, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 1, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be false
  end

  it 'should contain a grid position whose x co-ordinate is equal to start when start is less than end' do
    start_position = GridPosition.new 4, 10
    end_position = GridPosition.new 7, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 4, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be true
  end

  it 'should contain a grid position whose x co-ordinate is equal to start when start is greater than end' do
    start_position = GridPosition.new 8, 10
    end_position = GridPosition.new 3, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 8, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be true
  end

  it 'should contain a grid position whose x co-ordinate is equal to end when end is greater than start' do
    start_position = GridPosition.new 5, 10
    end_position = GridPosition.new 7, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 7, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be true
  end

  it 'should contain a grid position whose x co-ordinate is equal to end when end is less than start' do
    start_position = GridPosition.new 10, 10
    end_position = GridPosition.new 5, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 5, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be true
  end


  it 'should contain a grid position whose y co-ordinate is between start and end when start is less than end' do
    start_position = GridPosition.new 10, 5
    end_position = GridPosition.new 10, 10
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 10, 7

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be true
  end

  it 'should contain a grid position whose y co-ordinate is between start and end when start is greater than end' do
    start_position = GridPosition.new 10, 10
    end_position = GridPosition.new 10, 5
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 10, 7

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be true
  end

  it 'should not contain a grid position whose y co-ordinate is greater than end when end is greater than start' do
    start_position = GridPosition.new 10, 5
    end_position = GridPosition.new 10, 10
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 10, 11

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be false
  end

  it 'should not contain a grid position whose y co-ordinate is greater than start when start is greater than end' do
    start_position = GridPosition.new 10, 8
    end_position = GridPosition.new 10, 3
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 10, 9

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be false
  end

  it 'should not contain a grid position whose y co-ordinate is less than start when start is less than end' do
    start_position = GridPosition.new 10, 4
    end_position = GridPosition.new 10, 7
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 10, 3

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be false
  end

  it 'should not contain a grid position whose y co-ordinate is less than end when end is less than start' do
    start_position = GridPosition.new 10, 5
    end_position = GridPosition.new 10, 3
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 10, 1

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be false
  end

  it 'should contain a grid position whose y co-ordinate is equal to start when start is less than end' do
    start_position = GridPosition.new 4, 10
    end_position = GridPosition.new 7, 10
    boat = Boat.new start_position, end_position

    position_with_contained_x = GridPosition.new 4, 10

    is_contained = boat.contains position_with_contained_x

    expect(is_contained).to be true
  end

  it 'should contain a grid position whose y co-ordinate is equal to start when start is greater than end' do
    start_position = GridPosition.new 8, 10
    end_position = GridPosition.new 5, 10
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 8, 10

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be true
  end

  it 'should contain a grid position whose y co-ordinate is equal to end when end is greater than start' do
    start_position = GridPosition.new 10, 5
    end_position = GridPosition.new 10, 7
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 10, 7

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be true
  end

  it 'should contain a grid position whose y co-ordinate is equal to end when end is less than start' do
    start_position = GridPosition.new 10, 10
    end_position = GridPosition.new 10, 5
    boat = Boat.new start_position, end_position

    position_with_contained_y = GridPosition.new 10, 5

    is_contained = boat.contains position_with_contained_y

    expect(is_contained).to be true
  end
end