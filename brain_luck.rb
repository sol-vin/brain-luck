def brain_luck(code, input)
  output = ''
  data = [0]
  pointer = 0
  current_instruction = 0
  while current_instruction < code.length
    instruction = code[current_instruction]
    #interpret instruction
    if instruction == '>'
      #increment the pointer
      pointer += 1
      data << 0 if (pointer + 1) > data.length
    elsif instruction == '<'
      pointer -= 1
      if pointer < 0
        pointer = 0
        data.unshift 0
      end
    elsif instruction == '+'
      data[pointer] += 1
      data[pointer] = 0 if data[pointer] > 255
    elsif instruction == '-'
      data[pointer] -= 1
      data[pointer] = 255 if data[pointer] < 0
    elsif instruction == '.'
      output << data[pointer].chr
    elsif instruction == ','
      data[pointer] = input.slice!(0).bytes.first
    end
  end
  output
end
