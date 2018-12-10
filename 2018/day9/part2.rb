# Reference https://www.reddit.com/r/adventofcode/comments/a4i97s/2018_day_9_solutions/ebev45t

Circle = Struct.new(:left, :right) do
  
  def move_left
    if left.empty?
      self.left  = right
      self.right = []
    end
    right.unshift(left.pop)
  end

  def move_right
    if right.empty?
      self.right = left
      self.left  = []
    end
    left << right.shift
  end

  def add_to_left(value)
    left << value 
  end

  def remove_from_left
    (left.empty? ? right : left).pop
  end
end

def play(players_count, marbles)
  scores = Array.new(players_count, 0)
  circle = Circle.new([0], [])

  for i in (1..marbles)
    if i % 23 == 0
      7.times { circle.move_left }
      scores[i % players_count] += i + circle.remove_from_left
      circle.move_right
    else
      circle.move_right
      circle.add_to_left(i)
    end
  end

  scores.max
end

# sample input
p play(9, 25)
p play(10, 1618)
p play(13, 7999)
p play(17, 1104)
p play(21, 6111)
p play(30, 5807)

# part 1
p play(418, 70769)

# part 2
p play(418, 70769 * 100)