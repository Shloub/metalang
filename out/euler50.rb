require "scanf.rb"

def eratostene( t, max0 )
  n = 0
  for i in (2 ..  max0 - 1) do
      if t[i] == i then
          n += 1
          if (max0.to_f / i).to_i > i then
              j = i * i
              while j < max0 && j > 0 do
                  t[j] = 0
                  j += i
              end
          end
      end
      end
      return n
  end
  maximumprimes = 1000001
  era = [*0..maximumprimes-1].map { |j|
    
    next j
    }
  nprimes = eratostene(era, maximumprimes)
  primes = [*0..nprimes-1].map { |o|
    
    next 0
    }
  l = 0
  for k in (2 ..  maximumprimes - 1) do
      if era[k] == k then
          primes[l] = k
          l += 1
      end
      end
      printf "%d == %d\n", l, nprimes
      sum = [*0..nprimes-1].map { |i_|
        
        next primes[i_]
        }
      maxl = 0
      process = true
      stop = maximumprimes - 1
      len = 1
      resp = 1
      while process do
          process = false
          for i in (0 ..  stop) do
              if i + len < nprimes then
                  sum[i] += primes[i + len]
                  if maximumprimes > sum[i] then
                      process = true
                      if era[sum[i]] == sum[i] then
                          maxl = len
                          resp = sum[i]
                      end
                  else 
                      stop = [stop, i].min
                  end
              end
              end
              len += 1
          end
          printf "%d\n%d\n", resp, maxl
          
          