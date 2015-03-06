
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end
function eratostene( t, max0 )
  local n = 0
  for i = 2,max0 - 1 do
    if t[i] == i
    then
      n = n + 1;
      if trunc(max0 / i) > i
      then
        local j = i * i
        while j < max0 and j > 0
        do
        t[j] = 0;
        j = j + i;
        end
      end
    end
  end
  return n
end


local maximumprimes = 1000001
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
local sum = {}
for i_ = 0,nprimes - 1 do
  sum[i_] = primes[i_];
end
local maxl = 0
local process = true
local stop = maximumprimes - 1
local len = 1
local resp = 1
while process
do
process = false;
for i = 0,stop do
  if i + len < nprimes
  then
    sum[i] = sum[i] + primes[i + len];
    if maximumprimes > sum[i]
    then
      process = true;
      if era[sum[i]] == sum[i]
      then
        maxl = len;
        resp = sum[i];
      end
    else
      stop = math.min(stop, i);
    end
  end
end
len = len + 1;
end
io.write(string.format("%d\n%d\n", resp, maxl))
