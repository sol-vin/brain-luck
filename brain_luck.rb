def brain_luck(code, input)
  output = ''
  data = [0]
  pointer = 0
  code.each_char do |instruction| 
    #interpret instruction
    if instruction == '>'
      #increment the pointer
      pointer += 1
      if (pointer + 1) > data.length
        data << 0
      end
    elsif instruction == '<'
      pointer -= 1
    elsif instruction == '+'
      data[pointer] += 1
      if data[pointer] > 255
        data[pointer] = 0
      end
    elsif instruction == '-'
      data[pointer] -= 1
      if data[pointer] < 0
        data[pointer] = 255
      end
    elsif instruction == '.'
      output << data[pointer].chr
    elsif instruction == ','
      data[pointer] = input.slice!(0).bytes.first
    end
  end
  output
end
