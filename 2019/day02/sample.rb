filename = 'sample_input1.txt'

intcode_program = open(filename).readlines[0].split(',').map(&:to_i)

for i in (0..intcode_program.size/4)
  if intcode_program[i * 4] === 99
    break
  end

  opcode = intcode_program[i * 4]
  input1_position = intcode_program[i * 4 + 1]
  input2_position = intcode_program[i * 4 + 2]
  output_position = intcode_program[i * 4 + 3]

  if opcode === 1
    output = intcode_program[input1_position] + intcode_program[input2_position]
  elsif opcode === 2
    output = intcode_program[input1_position] * intcode_program[input2_position]
  end

  intcode_program[output_position] = output
end


print intcode_program