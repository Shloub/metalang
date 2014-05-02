require "scanf.rb"
def min2( a, b )
    if a < b then
      return (a);
    end
    return (b);
end

def eratostene( t, max_ )
    n = 0
    for i in (2 ..  max_ - 1) do
      if t[i] == i then
        n += 1
        j = i * i
        if (j.to_f / i).to_i == i then
          
=begin
 overflow test 
=end

          while j < max_ && j > 0 do
            t[j] = 0;
            j += i
          end
        end
      end
    end
    return (n);
end

maximumprimes = 1000001
era = [];
for j in (0 ..  maximumprimes - 1) do
  era[j] = j;
end
nprimes = eratostene(era, maximumprimes)
primes = [];
for o in (0 ..  nprimes - 1) do
  primes[o] = 0;
end
l = 0
for k in (2 ..  maximumprimes - 1) do
  if era[k] == k then
    primes[l] = k;
    l += 1
  end
end
printf "%d == %d\n", l, nprimes
sum = [];
for i_ in (0 ..  nprimes - 1) do
  sum[i_] = primes[i_];
end
maxl = 0
process = true
stop = maximumprimes - 1
len = 1
resp = 1
while process do
  process = false;
  for i in (0 ..  stop) do
    if i + len < nprimes then
      sum[i] = sum[i] + primes[i + len];
      if maximumprimes > sum[i] then
        process = true;
        if era[sum[i]] == sum[i] then
          maxl = len;
          resp = sum[i];
        end
      else
        stop = min2(stop, i);
      end
    end
  end
  len += 1
end
printf "%d\n%d\n", resp, maxl

