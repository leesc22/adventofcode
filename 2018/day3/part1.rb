filename = 'input.txt'

def calculate_overlapping_area(filename)
  claims    = open(filename).readlines
  frequency = Hash.new(0)
  
  claims.each do |claim|
    x, y, w, h = claim.chomp.match(/#\d+ @ (\d+),(\d+): (\d+)x(\d+)/).captures.map(&:to_i)
    for i in (x...x+w)
      for j in (y...y+h)
        frequency["#{i}-#{j}"] += 1
      end
    end
  end

  frequency.count { |k, v| v >= 2 }
end

puts "#{calculate_overlapping_area(filename)} square inches of fabric are within two or more claims."