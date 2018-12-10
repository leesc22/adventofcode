filename = 'input.txt'

def find_claim(filename)
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

  claims.each do |claim|
    nonoverlapping = true
    id, x, y, w, h = claim.chomp.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).captures.map(&:to_i)
    for i in (x...x+w)
      for j in (y...y+h)
        nonoverlapping = false if frequency["#{i}-#{j}"] > 1
      end
    end
    return id if nonoverlapping == true
  end
end

puts "##{find_claim(filename)} is the only claim that doesn't overlap."