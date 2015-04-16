class Player
  attr_reader :boats
  attr_reader :number

  def initialize number, boats
    @boats = boats
    @number = number
  end
end