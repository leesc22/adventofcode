require 'set'

filename = 'input.txt'

def calculate_area(filename, distance)
  coordinates = open(filename).readlines.map do |coordinate|
    coordinate.strip.split.map(&:to_i)
  end.sort_by { |x, y| [x, y] }
  area_size = 0
  largest_x = coordinates.max_by{ |c| c[0] }[0]
  largest_y = coordinates.max_by{ |c| c[1] }[1]

  for i in (0..largest_x)
    for j in (0..largest_y)
      total_distance = 0
      
      coordinates.each_with_index do |coordinate, index|
        total_distance += (coordinate.first - i).abs + (coordinate.last - j).abs
      end

      area_size += 1 if total_distance < distance
    end
  end
  
  area_size
end

distance = 10000
puts "The size of the region containing all locations which have a total distance to all given coordinates of less than #{distance} is #{calculate_area(filename, distance)}"