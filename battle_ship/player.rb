require_relative "battle_field"

class Player
  attr_accessor :name, :battle_field, :shots
  SHIPS = [:aircraft_carrier, :destroyer, :cruiser, :submarine, :battleship]

  def initialize(name, field)
    @name = name
    @battle_field = field
    @shots = []
  end

  def display_field
    @battle_field.warzone.map {|row| row.join(" ")}.join("\n")
  end

  def position_ships
    ####TODO need to check validity of inputs
    SHIPS.each do |ship|
      puts "Enter co-ordinates for the #{ship.to_s.upcase}:"
      x, y = get_coordinates
      puts "Enter Ship's orientation horizontal/vertical :"
      direction = gets.chomp.to_sym
      battle_field.deploy_ship(ship, x, y, direction)
    end
    puts "All Ships deployed to the Warzone !!"
  end

  def attack(player, x, y)
    hit = false
    player.battle_field.ships.each do |ship|
      if ship.hit?(x, y)
        ship.hit!(x, y)
        shots << [x, y]
        hit = true
      end
    end
    puts "HIT !!" if hit
    puts "MISS !!" if !hit
  end

  def ships_left
    battle_field.ship_count.size
  end

  def alive?
    !battle_field.ships.empty?
  end

  def dead?
    battle_field.ships.empty?
  end

  private

  def get_coordinates
    puts "Enter X co-ordinate"
    x = gets.chomp.to_i
    puts "Enter Y co-ordinate"
    y = gets.chomp.to_i
    return x, y
  end
end
