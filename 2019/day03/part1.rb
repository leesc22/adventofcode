filename = 'sample_input1.txt' # distance = 6
# filename = 'sample_input2.txt' # distance = 159
# filename = 'sample_input3.txt' # distance = 135
# filename = 'input.txt'

paths = open(filename).readlines.map do |path|
    path.strip.split(',')
end

grid = [[0]]
coordinate_x1 = 0
coordinate_y1 = 0
coordinate_x2 = 0
coordinate_y2 = 0
crosses = []

paths[0].each do |x|
  direction = x[0]
  distance = x[1].to_i

  case direction
  when "L"
    for i in (coordinate_x1 - distance)...(coordinate_x1)
      grid[i] ||= []
      grid[i][coordinate_y1] ||= 1
    end
    coordinate_x1 -= distance
  when "R"
    for i in (coordinate_x1 + 1)..(coordinate_x1 + distance)
      grid[i] ||= []
      grid[i][coordinate_y1] ||= 1
    end
    coordinate_x1 += distance
  when "U"
    for i in (coordinate_y1 + 1)..(coordinate_y1 + distance)
      grid[coordinate_x1][i] ||= 1
    end
    coordinate_y1 += distance
  when "D"
    for i in (coordinate_y1 - distance)...(coordinate_y1)
      grid[coordinate_x1][i] ||= 1
    end
    coordinate_y1 -= distance
  end
end

paths[1].each do |x|
  direction = x[0]
  distance = x[1].to_i

  case direction
  when "L"
    for i in (coordinate_x2 - distance)...(coordinate_x2)
      grid[i] ||= []
      if grid[i][coordinate_y2] === 1
        grid[i][coordinate_y2] = 2
        crosses.push([i, coordinate_y2])
      else
        grid[i][coordinate_y2] ||= 1
      end
    end
    coordinate_x2 -= distance
  when "R"
    for i in (coordinate_x2 + 1)..(coordinate_x2 + distance)
      grid[i] ||= []
      if grid[i][coordinate_y2] === 1
        grid[i][coordinate_y2] = 2
        crosses.push([i, coordinate_y2])
      else
        grid[i][coordinate_y2] ||= 1
      end
    end
    coordinate_x2 += distance
  when "U"
    for i in (coordinate_y2 + 1)..(coordinate_y2 + distance)
      if grid[coordinate_x2][i] === 1
        grid[coordinate_x2][i] = 2
        crosses.push([coordinate_x2, i])
      else
        grid[coordinate_x2][i] ||= 1
      end
    end
    coordinate_y2 += distance
  when "D"
    for i in (coordinate_y2 - distance)...(coordinate_y2)
      if grid[coordinate_x2][i] === 1
        grid[coordinate_x2][i] = 2
        crosses.push([coordinate_x2, i])
      else
        grid[coordinate_x2][i] ||= 1
      end
    end
    coordinate_y2 -= distance
  end
end

closest_point_manhattan_distance = grid.size * 2

crosses.each do |cross|
  manhattan_distance = cross[0] + cross[1]
  if manhattan_distance < closest_point_manhattan_distance
    closest_point_manhattan_distance = manhattan_distance
  end
end

puts "The Manhattan distance from the central port to the closest intersection is #{closest_point_manhattan_distance}"