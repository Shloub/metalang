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

def isPrime( n, primes, len )
    i = 0
    if n < 0 then
      n = -n
    end
    while primes[i] * primes[i] < n do
      if (mod(n, primes[i])) == 0 then
        return (false);
      end
      i += 1
    end
    return (true);
end

def test( a, b, primes, len )
    for n in (0 ..  200) do
      j = n * n + a * n + b
      if not(isPrime(j, primes, len)) then
        return (n);
      end
    end
    return (200);
end

maximumprimes = 1000
era = [];
for j in (0 ..  maximumprimes - 1) do
  era[j] = j
end
result = 0
max0 = 0
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
ma = 0
mb = 0
for b in (3 ..  999) do
  if era[b] == b then
    for a in (-999 ..  999) do
      n1 = test(a, b, primes, nprimes)
      n2 = test(a, -b, primes, nprimes)
      if n1 > max0 then
        max0 = n1
        result = a * b
        ma = a
        mb = b
      end
      if n2 > max0 then
        max0 = n2
        result = -a * b
        ma = a
        mb = -b
      end
    end
  end
end
printf "%d %d\n%d\n%d\n", ma, mb, max0, result

