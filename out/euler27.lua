function eratostene( t, max0 )
  local n = 0
  for i = 2,max0 - 1 do
  if t[i] == i
    then
      n = n + 1;
      local j = i * i
      while j < max0 and j > 0
      do
      t[j] = 0;
      j = j + i;
      end
    end
    end
    return n
  end
  
  function isPrime( n, primes, len )
    local i = 0
    if n < 0
    then
      n = -n;
    end
    while primes[i] * primes[i] < n
    do
    if (math.mod(n, primes[i])) == 0
    then
      return false
    end
    i = i + 1;
    end
    return true
  end
  
  function test( a, b, primes, len )
    for n = 0,200 do
    local j = n * n + a * n + b
      if not(isPrime(j, primes, len))
      then
        return n
      end
      end
      return 200
    end
    
    
    local maximumprimes = 1000
    local era = {}
    for j = 0,maximumprimes - 1 do
    era[j] = j;
      end
      local result = 0
      local max0 = 0
      local nprimes = eratostene(era, maximumprimes)
      local primes = {}
      for o = 0,nprimes - 1 do
      primes[o] = 0;
        end
        local l = 0
        for k = 2,maximumprimes - 1 do
        if era[k] == k
          then
            primes[l] = k;
            l = l + 1;
          end
          end
          io.write(string.format("%d == %d\n", l, nprimes))
          local ma = 0
          local mb = 0
          for b = 3,999 do
          if era[b] == b
            then
              for a = -999,999 do
              local n1 = test(a, b, primes, nprimes)
                local n2 = test(a, -b, primes, nprimes)
                if n1 > max0
                then
                  max0 = n1;
                  result = a * b;
                  ma = a;
                  mb = b;
                end
                if n2 > max0
                then
                  max0 = n2;
                  result = -a * b;
                  ma = a;
                  mb = -b;
                end
                end
              end
              end
              io.write(string.format("%d %d\n%d\n%d\n", ma, mb, max0, result))
              