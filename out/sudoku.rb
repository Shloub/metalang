require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def read_sudoku(  )
  out0 = [*0..9 * 9-1].map { |i|
    
    k = scanf("%d")[0]
    scanf("%*\n")
    next k
    }
  return out0
end


def print_sudoku( sudoku0 )
  for y in (0 ..  8) do
      for x in (0 ..  8) do
          printf "%d ", sudoku0[x + y * 9]
          if mod(x, 3) == 2 then
              print " "
          end
          end
          print "\n"
          if mod(y, 3) == 2 then
              print "\n"
          end
          end
          print "\n"
      end
      
      
      
      
      def sudoku_done( s )
        for i in (0 ..  80) do
            if s[i] == 0 then
                return false
            end
            end
            return true
        end
        
        
        def sudoku_error( s )
          out1 = false
          for x in (0 ..  8) do
              out1 = out1 || s[x] != 0 && s[x] == s[x + 9] || s[x] != 0 && s[x] == s[x + 9 * 2] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 2] || s[x] != 0 && s[x] == s[x + 9 * 3] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 3] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 3] || s[x] != 0 && s[x] == s[x + 9 * 4] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 4] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 4] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 4] || s[x] != 0 && s[x] == s[x + 9 * 5] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 5] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 5] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 5] || s[x + 9 * 4] != 0 && s[x + 9 * 4] == s[x + 9 * 5] || s[x] != 0 && s[x] == s[x + 9 * 6] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 6] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 6] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 6] || s[x + 9 * 4] != 0 && s[x + 9 * 4] == s[x + 9 * 6] || s[x + 9 * 5] != 0 && s[x + 9 * 5] == s[x + 9 * 6] || s[x] != 0 && s[x] == s[x + 9 * 7] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 7] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 7] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 7] || s[x + 9 * 4] != 0 && s[x + 9 * 4] == s[x + 9 * 7] || s[x + 9 * 5] != 0 && s[x + 9 * 5] == s[x + 9 * 7] || s[x + 9 * 6] != 0 && s[x + 9 * 6] == s[x + 9 * 7] || s[x] != 0 && s[x] == s[x + 9 * 8] || s[x + 9] != 0 && s[x + 9] == s[x + 9 * 8] || s[x + 9 * 2] != 0 && s[x + 9 * 2] == s[x + 9 * 8] || s[x + 9 * 3] != 0 && s[x + 9 * 3] == s[x + 9 * 8] || s[x + 9 * 4] != 0 && s[x + 9 * 4] == s[x + 9 * 8] || s[x + 9 * 5] != 0 && s[x + 9 * 5] == s[x + 9 * 8] || s[x + 9 * 6] != 0 && s[x + 9 * 6] == s[x + 9 * 8] || s[x + 9 * 7] != 0 && s[x + 9 * 7] == s[x + 9 * 8]
              end
              out2 = false
              for x in (0 ..  8) do
                  out2 = out2 || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 1] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 2] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 2] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 3] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 3] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 3] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 4] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 4] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 4] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 4] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 5] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 5] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 5] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 5] || s[x * 9 + 4] != 0 && s[x * 9 + 4] == s[x * 9 + 5] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 6] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 6] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 6] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 6] || s[x * 9 + 4] != 0 && s[x * 9 + 4] == s[x * 9 + 6] || s[x * 9 + 5] != 0 && s[x * 9 + 5] == s[x * 9 + 6] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 7] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 7] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 7] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 7] || s[x * 9 + 4] != 0 && s[x * 9 + 4] == s[x * 9 + 7] || s[x * 9 + 5] != 0 && s[x * 9 + 5] == s[x * 9 + 7] || s[x * 9 + 6] != 0 && s[x * 9 + 6] == s[x * 9 + 7] || s[x * 9] != 0 && s[x * 9] == s[x * 9 + 8] || s[x * 9 + 1] != 0 && s[x * 9 + 1] == s[x * 9 + 8] || s[x * 9 + 2] != 0 && s[x * 9 + 2] == s[x * 9 + 8] || s[x * 9 + 3] != 0 && s[x * 9 + 3] == s[x * 9 + 8] || s[x * 9 + 4] != 0 && s[x * 9 + 4] == s[x * 9 + 8] || s[x * 9 + 5] != 0 && s[x * 9 + 5] == s[x * 9 + 8] || s[x * 9 + 6] != 0 && s[x * 9 + 6] == s[x * 9 + 8] || s[x * 9 + 7] != 0 && s[x * 9 + 7] == s[x * 9 + 8]
                  end
                  out3 = false
                  for x in (0 ..  8) do
                      out3 = out3 || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] == s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] == s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] == s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] != 0 && s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[mod(x, 3) * 3 * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] != 0 && s[(mod(x, 3) * 3 + 1) * 9 + (x.to_f / 3).to_i * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] != 0 && s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 2] || s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] != 0 && s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + (x.to_f / 3).to_i * 3 + 2]
                      end
                      return out1 || out2 || out3
                  end
                  
                  
                  def solve( sudoku0 )
                    if sudoku_error(sudoku0) then
                        return false
                    end
                    if sudoku_done(sudoku0) then
                        return true
                    end
                    for i in (0 ..  80) do
                        if sudoku0[i] == 0 then
                            for p in (1 ..  9) do
                                sudoku0[i] = p
                                if solve(sudoku0) then
                                    return true
                                end
                                end
                                sudoku0[i] = 0
                                return false
                            end
                            end
                            return false
                        end
                        sudoku0 = read_sudoku()
                        print_sudoku(sudoku0)
                        if solve(sudoku0) then
                            print_sudoku(sudoku0)
                         else 
                            print "no solution\n"
                        end
                        
                        