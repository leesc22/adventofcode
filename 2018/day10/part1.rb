# Reference https://github.com/petertseng/adventofcode-rb-2018/blob/master/10_the_stars_align.rb

def analyse(filename)
  records = open(filename).readlines.map { |e| e.scan(/-?\d+/).map(&:to_i) }

  prev_positions = nil
  prev_range_y   = 1 / 0.0

  0.step do |t|
    positions = records.map { |a, b, c, d| [a + c * t, b + d * t] }

    min_y, max_y = positions.map(&:last).minmax
    range_y = max_y - min_y + (min_y <= 0 ? 1 : 0)

    if range_y > prev_range_y
      min_x, max_x = prev_positions.map(&:first).minmax
      min_y, max_y = prev_positions.map(&:last).minmax

      puts "After #{t-1} second: " # part 2
      (min_y..max_y).each do |y|
        (min_x..max_x).each do |x|
          print prev_positions.include?([x, y]) ? "# " : ". "
        end
        print "\n"
      end

      break
    end

    prev_positions = positions
    prev_range_y   = range_y
  end  
end

analyse('sample_input.txt')

analyse('input.txt')