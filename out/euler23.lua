
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


local maximumprimes = 30001
local era = {}
for s = 0,maximumprimes - 1 do
  era[s] = s;
end
local nprimes = eratostene(era, maximumprimes)
local primes = {}
for t = 0,nprimes - 1 do
  primes[t] = 0;
end
local l = 0
for k = 2,maximumprimes - 1 do
  if era[k] == k
  then
    primes[l] = k;
    l = l + 1;
  end
end
local n = 100
--[[ 28124 ça prend trop de temps mais on arrive a passer le test --]]
local abondant = {}
for p = 0,n + 1 - 1 do
  abondant[p] = false;
end
local summable = {}
for q = 0,n + 1 - 1 do
  summable[q] = false;
end
local sum = 0
for r = 2,n do
  local other = sumdiv(nprimes, primes, r) - r
  if other > r
  then
    abondant[r] = true;
  end
end
for i = 1,n do
  for j = 1,n do
    if abondant[i] and abondant[j] and i + j <= n
    then
      summable[i + j] = true;
    end
  end
end
for o = 1,n do
  if not(summable[o])
  then
    sum = sum + o;
  end
end
io.write(string.format("\n%d\n", sum))
