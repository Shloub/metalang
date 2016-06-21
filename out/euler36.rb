require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def palindrome2( pow2, n )
  t = [*0..20-1].map { |i|
    
    next mod((n.to_f / pow2[i]).to_i, 2) == 1
    }
  nnum = 0
  for j in (1 ..  19) do
      if t[j] then
          nnum = j
      end
      end
      for k in (0 ..  (nnum.to_f / 2).to_i) do
          if t[k] != t[nnum - k] then
              return false
          end
          end
          return true
      end
      p = 1
      pow2 = [*0..20-1].map { |i|
        
        p *= 2
        next (p.to_f / 2).to_i
        }
      sum = 0
      for d in (1 ..  9) do
          if palindrome2(pow2, d) then
              printf "%d\n", d
              sum += d
          end
          if palindrome2(pow2, d * 10 + d) then
              printf "%d\n", d * 10 + d
              sum += d * 10 + d
          end
          end
          for a0 in (0 ..  4) do
              a = a0 * 2 + 1
              for b in (0 ..  9) do
                  for c in (0 ..  9) do
                      num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a
                      if palindrome2(pow2, num0) then
                          printf "%d\n", num0
                          sum += num0
                      end
                      num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a
                      if palindrome2(pow2, num1) then
                          printf "%d\n", num1
                          sum += num1
                      end
                      end
                      num2 = a * 100 + b * 10 + a
                      if palindrome2(pow2, num2) then
                          printf "%d\n", num2
                          sum += num2
                      end
                      num3 = a * 1000 + b * 100 + b * 10 + a
                      if palindrome2(pow2, num3) then
                          printf "%d\n", num3
                          sum += num3
                      end
                      end
                      end
                      printf "sum=%d\n", sum
                      
                      