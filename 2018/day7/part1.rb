filename = 'input.txt'

def analyse(filename)
  steps = open(filename).readlines.map { |e| e.scan(/ ([A-Z]) /).flatten }
  order = Array.new
  last  = steps.map(&:last).uniq

  while steps.size > 0
    before = steps.map(&:first).uniq
    after  = steps.map(&:last).uniq

    chosen = (before - after).sort.first

    order << chosen

    steps.reject! { |e| e.first == chosen }
  end

  order << last - order
  order.join
end

puts "The correct order is #{analyse(filename)}"