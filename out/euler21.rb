require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def eratostene( t, max0 )
    n = 0
    for i in (2 ..  max0 - 1) do
      if t[i] == i then
        n += 1
        j = i * i
        while j < max0 && j > 0 do
          t[j] = 0
          j += i
        end
      end
    end
    return (n);
end

def fillPrimesFactors( t, n, primes, nprimes )
    for i in (0 ..  nprimes - 1) do
      d = primes[i]
      while (mod(n, d)) == 0 do
        t[d] = t[d] + 1
        n = (n.to_f / d).to_i
      end
      if n == 1 then
        return (primes[i]);
      end
    end
    return (n);
end

def sumdivaux2( t, n, i )
    while i < n && t[i] == 0 do
      i += 1
    end
    return (i);
end

def sumdivaux( t, n, i )
    if i > n then
      return (1);
    elsif t[i] == 0 then
      return (sumdivaux(t, n, sumdivaux2(t, n, i + 1)));
    else
      o = sumdivaux(t, n, sumdivaux2(t, n, i + 1))
      out0 = 0
      p = i
      for j in (1 ..  t[i]) do
        out0 += p
        p *= i
      end
      return ((out0 + 1) * o);
    end
end

def sumdiv( nprimes, primes, n )
    t = [];
    for i in (0 ..  n + 1 - 1) do
      t[i] = 0
    end
    max0 = fillPrimesFactors(t, n, primes, nprimes)
    return (sumdivaux(t, max0, 0));
end

maximumprimes = 1001
era = [];
for j in (0 ..  maximumprimes - 1) do
  era[j] = j
end
nprimes = eratostene(era, maximumprimes)
primes = [];
for o in (0 ..  nprimes - 1) do
  primes[o] = 0
end
l = 0
for k in (2 ..  maximumprimes - 1) do
  if era[k] == k then
    primes[l] = k
    l += 1
  end
end
printf "%d == %d\n", l, nprimes
sum = 0
for n in (2 ..  1000) do
  other = sumdiv(nprimes, primes, n) - n
  if other > n then
    othersum = sumdiv(nprimes, primes, other) - other
    if othersum == n then
      printf "%d & %d\n", other, n
      sum += other + n
    end
  end
end
printf "\n%d\n", sum

