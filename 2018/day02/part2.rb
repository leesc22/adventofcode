filename = 'input.txt'

def find_common_letters(filename)
  box_ids = open(filename).readlines

  for i in (0...box_ids.size)
    for j in (i+1...box_ids.size)
      arr = box_ids[i].strip.chars.zip(box_ids[j].strip.chars)
      diff = arr.select { |a, b| a != b }
      if diff.count == 1
        return box_ids[i].sub(diff[0][0], "")
      end
    end
  end
end

puts "The letters common between the two correct box IDs are #{find_common_letters(filename)}"