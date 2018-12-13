# Use summed-area table to generate the sum of values in a rectangular subset of a grid - https://en.wikipedia.org/wiki/Summed-area_table

def calculate_power_level(coordinate, grid_serial_number)
  rack_id = coordinate[0] + 10
  power_level = ((rack_id * coordinate[1] + grid_serial_number) * rack_id).to_s[-3].to_i - 5
end

def find_largest_total_power_square(grid_serial_number)
  sum_table   = Hash.new

  (1..300).each do |y|
    (1..300).each do |x|
      power = calculate_power_level([x, y], grid_serial_number)
      a = sum_table[[x-1,y-1]] || 0
      b = sum_table[[x,y-1]] || 0
      c = sum_table[[x-1,y]] || 0
      sum_table[[x,y]] = power + c + b - a
    end
  end

  max_power = 0
  coordinate_and_size = nil

  (1..300).each do |y|
    (1..300).each do |x|
      (1..20).each do |z|
        a = sum_table[[x - 1, y - 1]]
        b = sum_table[[x - 1 + z, y - 1]]
        c = sum_table[[x - 1, y + (z-1)]]
        d = sum_table[[x -1 + z, y - 1 + z]]

        if a && b && c && d
          power_grid_z = d + a - b - c
  
          if power_grid_z > max_power
            max_power = power_grid_z 
            coordinate_and_size = [x, y, z]
          end
        end

      end
    end
  end

  coordinate_and_size
end

p find_largest_total_power_square(18) # 90,269,16
p find_largest_total_power_square(42) # 232,251,12
p find_largest_total_power_square(9445) # 231,107,14