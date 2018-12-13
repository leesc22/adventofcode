def calculate_power_level(coordinate, grid_serial_number)
  rack_id = coordinate[0] + 10
  power_level = ((rack_id * coordinate[1] + grid_serial_number) * rack_id).to_s[-3].to_i - 5
end

p calculate_power_level([3, 5], 8) == 4
p calculate_power_level([122, 79], 57) == -5
p calculate_power_level([217, 196], 39) == 0
p calculate_power_level([101, 153], 71) == 4

def find_largest_total_power_square(grid_serial_number)
  total = Hash.new(0)

  (1..300).each do |y|
    (1..300).each do |x|
      power = calculate_power_level([x, y], grid_serial_number)

      min_x = x - 2
      min_x = 1 if min_x < 1
      min_y = y - 2
      min_y = 1 if min_y < 1

      (min_y..y).each do |b|
        (min_x..x).each do |a|
          total[[a,b]] += power
        end
      end

    end
  end

  total.key(total.values.max)
end

p find_largest_total_power_square(18) == [33, 45]
p find_largest_total_power_square(42) == [21, 61]
p find_largest_total_power_square(9445) # [233, 36]