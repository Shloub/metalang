
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end
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

function fillPrimesFactors( t, n, primes, nprimes )
  for i = 0,nprimes - 1 do
    local d = primes[i]
    while (math.mod(n, d)) == 0
    do
    t[d] = t[d] + 1;
    n = trunc(n / d);
    end
    if n == 1
    then
      return primes[i]
    end
  end
  return n
end

function sumdivaux2( t, n, i )
  while i < n and t[i] == 0
  do
  i = i + 1;
  end
  return i
end

function sumdivaux( t, n, i )
  if i > n then
    return 1
  elseif t[i] == 0
  then
    return sumdivaux(t, n, sumdivaux2(t, n, i + 1))
  else
    local o = sumdivaux(t, n, sumdivaux2(t, n, i + 1))
    local out0 = 0
    local p = i
    for j = 1,t[i] do
      out0 = out0 + p;
      p = p * i;
    end
    return (out0 + 1) * o
  end
end

function sumdiv( nprimes, primes, n )
  local t = {}
  for i = 0,n + 1 - 1 do
    t[i] = 0;
  end
  local max0 = fillPrimesFactors(t, n, primes, nprimes)
  return sumdivaux(t, max0, 0)
end


local maximumprimes = 1001
local era = {}
for j = 0,maximumprimes - 1 do
  era[j] = j;
end
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
local sum = 0
for n = 2,1000 do
  local other = sumdiv(nprimes, primes, n) - n
  if other > n
  then
    local othersum = sumdiv(nprimes, primes, other) - other
    if othersum == n
    then
      io.write(string.format("%d & %d\n", other, n))
      sum = sum + other + n;
    end
  end
end
io.write(string.format("\n%d\n", sum))
