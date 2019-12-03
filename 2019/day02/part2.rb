filename = 'input.txt'

original_intcode_program = open(filename).readlines[0].split(',').map(&:to_i)

def computer(intcode_program)
  for x in (0..intcode_program.size/4)
    if intcode_program[x * 4] === 99
      break
    end

    opcode = intcode_program[x * 4]
    input1_position = intcode_program[x * 4 + 1]
    input2_position = intcode_program[x * 4 + 2]
    output_position = intcode_program[x * 4 + 3]

    if opcode === 1
      output = intcode_program[input1_position] + intcode_program[input2_position]
    elsif opcode === 2
      output = intcode_program[input1_position] * intcode_program[input2_position]
    end

    intcode_program[output_position] = output
  end
end

for i in 0..99
  for j in 0..99
    intcode_program = original_intcode_program.dup

    intcode_program[1] = i
    intcode_program[2] = j

    computer(intcode_program)

    if intcode_program[0] === 19690720
      puts "The answer is #{100 * intcode_program[1] + intcode_program[2]}"
      return
    end
  end
end