input = "347312-805915"

range = input.split('-').map(&:to_i)
valid_passwords = Array.new

def check_double(number)
  number.to_s.index(/(\d)\1+/)
end

def check_increment(number)
  number.to_s == number.to_s.chars.sort.join
end

for i in range.first..range.last
  flag = true
  flag = false unless check_double(i)
  flag = false unless check_increment(i)
  valid_passwords.push(i) if flag == true
end

puts "#{valid_passwords.size} different passwords"