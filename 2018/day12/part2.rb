# Reference https://www.reddit.com/r/adventofcode/comments/a5eztl/2018_day_12_solutions/ebm4fz5

def analyse(filename, total_generation)
  records = open(filename).readlines
  prev_state = records.shift.chomp[/initial state: (.*)/, 1]
  prev_state = "..." + prev_state + "..."
  first_index = -3
  sums = []
  sum = 0
  prev_state.chars.each.with_index(first_index) do |c, i| 
    sum += c == "#" ? i : 0 
  end
  sums[0] = sum
  differences = Array.new(10)

  patterns = {}
  records[1..-1].each do |line|
    key, value = line.match(/(.*) => (.)/).captures
    patterns[key] = value
  end

  stable_generation = 1.step do |generation|
    state = ""
    for i in (2...(prev_state.size - 2))
      state += patterns[prev_state[i - 2, 5]] || "."
    end

    first_index += 2

    if state.index("#") == 2 
      state.prepend(".") 
      first_index -= 1
    end

    if state.index("#") == 1 
      state.prepend("..")
      first_index -= 2
    end

    if state.index("#") == 0 
      state.prepend("...")
      first_index -= 3
    end

    state << "." if state.rindex("#") == state.size - 3
    state << ".." if state.rindex("#") == state.size - 2
    state << "..." if state.rindex("#") == state.size - 1

    prev_state = state

    sum = 0
    prev_state.chars.each.with_index(first_index) do |c, i| 
      sum += c == "#" ? i : 0 
    end
    sums << sum
    differences.shift
    differences << (sums[generation] - sums[generation - 1])

    break generation if differences.uniq.length == 1
    return sums[generation] if generation == total_generation
  end

  sums[stable_generation] + differences[0] * (total_generation - stable_generation)
end

total_generation = 20
puts "After #{total_generation} generations, sum of the numbers of all pots which contain a plant is #{analyse('sample_input.txt', total_generation)}"

puts "After #{total_generation} generations, sum of the numbers of all pots which contain a plant is #{analyse('input.txt', total_generation)}"

total_generation = 50000000000
puts "After #{total_generation} generations, sum of the numbers of all pots which contain a plant is #{analyse('input.txt', total_generation)}"


