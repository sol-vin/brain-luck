def brain_luck(code, input)
  output = ''
  data = [0]
  pointer = 0
  current_instruction = 0
  while current_instruction < code.length                       #Keep going until we hit the end of the code
    if code[current_instruction] == ?[ && data[pointer] == 0    #seek thorugh instructions if there is a [ or ]
      bracket_count = 0                                         #counts how many open brackets we have yet to close
      while current_instruction < code.length                   #dont keep going if we go out of bounds
        current_instruction += 1                                #Move the current instruction forward by one
        if code[current_instruction] == ?[                      #Is the current instructiuon an open bracket?
          bracket_count += 1                                    #If so, count it, that's one more to close
        elsif code[current_instruction] == ?]                   #Is the current instruction and close bracket
          if bracket_count == 0                                 #Are there no other brackets that need closing?
            break                                               #Get the fuck outta here
          else                                                  #We still have an extra bracket to close?
            bracket_count -= 1                                  #One less bracket to close
          end
        end
      end
    elsif code[current_instruction] == ?]
      if  code[current_instruction] == ?] && data[pointer] != 0                #seek thorugh instructions if there is a [ or ]
        bracket_count = 0                                         #counts how many open brackets we have yet to close
        while current_instruction > 0                             #dont keep going if we go out of bounds
          current_instruction -= 1                                #Move the current instruction forward by one
          if code[current_instruction] == ?]                      #Is the current instructiuon an open bracket?
            bracket_count += 1                                    #If so, count it, that's one more to close
          elsif code[current_instruction] == ?[                   #Is the current instruction and close bracket
            if bracket_count == 0                                 #Are there no other brackets that need closing?
              break                                               #Get the fuck outta here
            else                                                  #We still have an extra bracket to close?
              bracket_count -= 1                                  #One less bracket to close
            end
          end
        end
      end
    elsif code[current_instruction] == ?>                       #increment pointer instruction
      pointer += 1                                              #increment the pointer
      data << 0 if (pointer + 1) > data.length                  #Add an extra cell to memory
    elsif code[current_instruction] == ?<                       #decrement pointer instruction
      pointer -= 1                                              #decrement the pointer
      if pointer < 0                                            #if the pointer is negative
        pointer = 0                                             #clamp pointer to 0
        data.unshift 0                                          #prepend a new memory cell
      end
    elsif code[current_instruction] == ?+                       #increment byte instruction
      data[pointer] += 1                                        #increment the byte at the pointer
      data[pointer] = 0 if data[pointer] > 255                  #wrap byte around if it is out of bounds
    elsif code[current_instruction] == ?-                       #decrement byte instruction
      data[pointer] -= 1                                        #decrement byte at pointer
      data[pointer] = 255 if data[pointer] < 0                  #wrap pointer if it goes out of bounds
    elsif code[current_instruction] == ?.                       #output byte instruction
      output << data[pointer].chr                               #change ascii code to character and put into output
    elsif code[current_instruction] == ?,                       #input byte instruction
      data[pointer] = input.slice!(0).bytes.first               #Grab the first char out of the input string
    end
    current_instruction += 1                                    #move to next instruction
  end
  output
end
