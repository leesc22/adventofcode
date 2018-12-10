# Reference https://www.reddit.com/r/adventofcode/comments/a47ubw/2018_day_8_solutions/ebc99t8

filename = 'input.txt'

def analyse(filename)
  numbers = open(filename).readlines[0].split(" ").map(&:to_i)
  child_stack  = [numbers.shift]
  meta_stack   = [numbers.shift]
  children = [[]]
  metadata = [[]]

  while child_stack.size > 0
    if child_stack[-1] > 0
      child_stack[-1] -= 1

      child_stack << numbers.shift
      meta_stack  << numbers.shift
      children    << []
      metadata    << []
    elsif meta_stack[-1] > 0
      metadata[-1] << numbers.shift
      meta_stack[-1] -= 1 
    else
      c = children.pop
      m = metadata.pop
      v = 
        if c.size > 0
          m.map { |e| c[e-1] }.compact.reduce(0, &:+)
        else
          m.sum
        end

      if children.size > 0 
        children[-1] << v
      else 
        return v
      end
   
      child_stack.pop
      meta_stack.pop
    end
  end
end

puts "The value of the root node is #{analyse(filename)}"