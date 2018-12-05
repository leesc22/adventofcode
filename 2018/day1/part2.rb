filename  = 'input.txt'

def find_frequency(filename)
  numbers   = open(filename).readlines.map(&:to_i)
  sum       = 0
  frequency = Hash.new(0)

  loop do
    numbers.each do |n|
      sum += n
      frequency[sum] += 1
      return sum if frequency[sum] == 2
    end
  end
end

puts "The first frequency the device reaches twice is #{find_frequency(filename)}"
