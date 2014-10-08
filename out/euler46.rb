require "scanf.rb"
def eratostene( t, max0 )
    n = 0
    for i in (2 ..  max0 - 1) do
      if t[i] == i then
        n += 1
        j = i * i
        if (j.to_f / i).to_i == i then
          
=begin
 overflow test 
=end

          while j < max0 && j > 0 do
            t[j] = 0;
            j += i
          end
        end
      end
    end
    return (n);
end

maximumprimes = 6000
era = [];
for j_ in (0 ..  maximumprimes - 1) do
  era[j_] = j_;
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
canbe = [];
for i_ in (0 ..  maximumprimes - 1) do
  canbe[i_] = false;
end
for i in (0 ..  nprimes - 1) do
  for j in (0 ..  maximumprimes - 1) do
    n = primes[i] + 2 * j * j
    if n < maximumprimes then
      canbe[n] = true;
    end
  end
end
for m in (1 ..  maximumprimes) do
  m2 = m * 2 + 1
  if m2 < maximumprimes && not(canbe[m2]) then
    printf "%d\n", m2
  end
end

