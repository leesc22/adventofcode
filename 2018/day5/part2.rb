filename = 'input.txt'

def trigger_polymer(filename)
  polymer = open(filename).readlines[0]
  polymer_length = polymer.size

  ("a".."z").each do |c|
    new_length = react(polymer.gsub(Regexp.new(c, true), ''))
    polymer_length = new_length if new_length < polymer_length
  end

  polymer_length
end

def react(polymer)
  loop do
    for i in (1...polymer.size)
      possible_reactions = 
        if polymer[i-1] =~ /[a-z]/
          polymer[i-1].upcase == polymer[i]
        else
          polymer[i-1].downcase == polymer[i]
        end

      if possible_reactions
        polymer.slice!(i-1, 2)
        break
      end
    end

    return polymer.size if possible_reactions == false
  end
end

puts "#{trigger_polymer(filename)} units remain after fully reacting the polymer scanned."