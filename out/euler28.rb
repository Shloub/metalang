require "scanf.rb"

def sumdiag( n )
  nterms = n * 2 - 1
  un = 1
  sum = 1
  for i in (0 ..  nterms - 2) do
      d = 2 * (1 + (i.to_f / 4).to_i)
      un += d
      # print int d print "=>" print un print " " 
      
      sum += un
      end
      return sum
  end
  printf "%d", sumdiag(1001)
  
  