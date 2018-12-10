filename = 'input.txt'

def analyse(filename)
  numbers = open(filename).readlines[0].split(" ").map(&:to_i)
  child_stack  = []
  meta_stack   = []
  metadata_sum = 0

  # First node
  child_stack << numbers.shift
  meta_stack  << numbers.shift

  while numbers.size > 0
    if child_stack[-1] > 0
      child_stack[-1] -= 1

      child_stack << numbers.shift
      meta_stack  << numbers.shift
    else
      child_stack.pop
      metadata_sum += numbers.slice!(0, meta_stack[-1]).reduce(&:+)
      meta_stack.pop
    end
  end

  metadata_sum
end

puts "The sum of all metadata entries is #{analyse(filename)}"