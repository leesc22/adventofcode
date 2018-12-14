def analyse(filename)
  records = open(filename).readlines
  prev_state = records.shift.chomp[/initial state: (.*)/, 1]
  prev_state = "..." + prev_state + "..."
  first_index = -3

  patterns = {}
  records[1..-1].each do |line|
    key, value = line.match(/(.*) => (.)/).captures
    patterns[key] = value
  end

  20.times do |generation|
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
  end

  sum = 0
  prev_state.chars.each.with_index(first_index) do |c, i| 
    sum += c == "#" ? i : 0 
  end
  sum
end

puts "After 20 generations, sum of the numbers of all pots which contain a plant is #{analyse('sample_input.txt')}"

puts "After 20 generations, sum of the numbers of all pots which contain a plant is #{analyse('input.txt')}"


