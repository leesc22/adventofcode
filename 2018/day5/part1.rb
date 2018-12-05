filename = 'input.txt'

def trigger_polymer(filename)
  polymer = open(filename).readlines[0]

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