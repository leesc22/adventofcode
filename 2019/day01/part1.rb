filename = 'input.txt'

masses = open(filename).readlines.map(&:to_i)
total_fuel = 0

masses.each do |mass|
  fuel = mass / 3 - 2
  total_fuel += fuel
end

puts "The sum of the fuel requirements for all of the moudules on spacecraft is #{total_fuel}"