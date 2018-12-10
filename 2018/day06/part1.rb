require 'set'

filename = 'input.txt'

def calculate_area(filename)
  coordinates = open(filename).readlines.map do |coordinate|
    coordinate.strip.split.map(&:to_i)
  end.sort_by { |x, y| [x, y] }
  area = Hash.new(0)
  largest_x = coordinates.max_by{ |c| c[0] }[0]
  largest_y = coordinates.max_by{ |c| c[1] }[1]
  max_distance = largest_x + largest_y
  infinite_area = Set.new

  for i in (0..largest_x)
    for j in (0..largest_y)
      closest_distance = max_distance
      closest_index    = -1
      
      coordinates.each_with_index do |coordinate, index|
        manhattan_distance = (coordinate.first - i).abs + (coordinate.last - j).abs
        if manhattan_distance < closest_distance
          closest_distance = manhattan_distance 
          closest_index    = index
        elsif manhattan_distance == closest_distance
          closest_index = nil
        end
      end

      area[closest_index] += 1 if closest_index

      if i == 0 || j == 0 || i == largest_x || j == largest_y
        infinite_area << closest_index if closest_index
      end
    end
  end
  
  area.reject { |k, v| infinite_area.include?(k) }.max_by(&:last).last
end

puts "The size of the largest area is #{calculate_area(filename)}"