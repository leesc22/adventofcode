def calculate_power_level(coordinate, grid_serial_number)
  rack_id = coordinate[0] + 10
  power_level = ((rack_id * coordinate[1] + grid_serial_number) * rack_id).to_s[-3].to_i - 5
end

def find_largest_total_power_square(grid_serial_number, size)
  total = Hash.new(0)

  (1..300).each do |y|
    (1..300).each do |x|
      power = calculate_power_level([x, y], grid_serial_number)

      min_x = x - (size - 1)
      min_x = 1 if min_x < 1
      min_y = y - (size - 1)
      min_y = 1 if min_y < 1

      (min_y..y).each do |b|
        (min_x..x).each do |a|
          total[[a,b]] += power
        end
      end

    end
  end

  max_power = total.values.max
  [total.key(max_power), size, max_power].flatten
end

# assume grid size not exceeding 20

p ((1..20).map do |i|
  find_largest_total_power_square(18, i)
end).max_by{ |e| e.last } # 90,269,16

p ((1..20).map do |i|
  find_largest_total_power_square(42, i)
end).max_by{ |e| e.last } # 232,251,12

p ((1..20).map do |i|
  find_largest_total_power_square(9445, i)
end).max_by{ |e| e.last } # 231,107,14