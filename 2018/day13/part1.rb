class Cart

  attr_reader :x, :y, :direction, :count

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction
    @cycle = [1, 2, 3].cycle
    @count = @cycle.next
  end

  def move
    case @direction
    when "<"
      move_left
    when ">"
      move_right
    when "^"
      move_up
    when "v"
      move_down
    end
  end

  def turn_left
    case @direction
    when "<"
      @direction = "v"
    when ">"
      @direction = "^"
    when "^"
      @direction = "<"
    when "v"
      @direction = ">"
    end
  end

  def turn_right
    case @direction
    when "<"
      @direction = "^"
    when ">"
      @direction = "v"
    when "^"
      @direction = ">"
    when "v"
      @direction = "<"
    end
  end

  def next_cycle
    @count = @cycle.next  
  end

  private
    def move_left
      @x -= 1
    end

    def move_right
      @x += 1
    end

    def move_up
      @y -= 1
    end

    def move_down
      @y += 1
    end
end

records = open('input.txt').readlines.map do |line|
  line.chomp.chars
end

carts = []
frequency = Hash.new(0)
crash = false

records.each_with_index do |row, y|
  row.each_with_index do |char, x|
    case char
    when "<", ">", "^", "v"
      carts << Cart.new(x, y, char)
      frequency["#{x}-#{y}"] += 1
    end
  end
end

loop do
  carts.each do |cart|
    frequency["#{cart.x}-#{cart.y}"] -= 1
    cart.move

    case records[cart.y][cart.x]
    when "/"
      case cart.direction
      when "<", ">"
        cart.turn_left
      when "^", "v"
        cart.turn_right
      end
    when "\\"
      case cart.direction
      when "<", ">"
        cart.turn_right
      when "^", "v"
        cart.turn_left
      end
    when "+"
      case cart.count
      when 1
        cart.turn_left
      when 3
        cart.turn_right
      end
      cart.next_cycle
    end

    frequency["#{cart.x}-#{cart.y}"] += 1

    return p "#{cart.x}-#{cart.y}" if frequency["#{cart.x}-#{cart.y}"] > 1
  end
end