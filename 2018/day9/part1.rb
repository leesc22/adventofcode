def play(players_count, marbles)
  # Setup variables
  players = (0...players_count).cycle
  position = [0]
  current_player   = 0
  current_position = 0
  scores = Array.new(players_count, 0)

  for i in (1..marbles)
    current_player = players.next

    new_position = 
      if current_position == position.size-1
        1 
      else
        current_position + 2
      end

    if i % 23 == 0
      scores[current_player] += i
      current_position -= 7
      scores[current_player] += position.delete_at(current_position)
      current_position += 1 if current_position < 0
    else
      position[new_position, 0] = i
      current_position = position.index(i)
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

# part 2 (taking too long time using normal array)
p play(418, 70769 * 100)