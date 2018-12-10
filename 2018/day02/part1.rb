filename = 'input.txt'

def calculate_checksum(filename)
  box_ids     = open(filename).readlines
  twice_count = 0
  three_count = 0

  box_ids.each do |id|
	  frequency = Hash.new(0)
  	id.each_char do |c|
	    frequency[c] += 1
  	end
  	twice_count += 1 if frequency.has_value?(2)
  	three_count += 1 if frequency.has_value?(3)
  end

  twice_count * three_count
end

puts "The checksum for the list of box IDs is #{calculate_checksum(filename)}"