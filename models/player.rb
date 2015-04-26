class Player
  attr_reader :boats
  attr_reader :number

  def initialize number, boats
    @boats = boats
    @number = number
  end

  def has_lost
    @boats.each do |boat|
      unless boat.sunk
        return false
      end
    end
    true
  end

end