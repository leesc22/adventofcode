filename = 'input.txt'

masses = open(filename).readlines.map(&:to_i)
$total_fuel = 0

def fuel_for_fuel(mass)
  fuel = mass / 3 - 2
  return if fuel <= 0
  $total_fuel += fuel
  fuel_for_fuel(fuel)
end

masses.each do |mass|
  fuel = mass / 3 - 2
  $total_fuel += fuel
  fuel_for_fuel(fuel)
end

puts "The sum of the fuel requirements for all of the moudules on spacecraft when also taking into account the mass of the added fuels is #{$total_fuel}"