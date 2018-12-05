# https://code-maven.com/sum-of-numbers-in-file-using-ruby

filename = 'input.txt'

puts "The resulting frequency is #{open(filename).readlines.map(&:to_i).reduce :+}"
