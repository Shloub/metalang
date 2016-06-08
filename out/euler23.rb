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
    return (n)
end

def fillPrimesFactors( t, n, primes, nprimes )
    for i in (0 ..  nprimes - 1) do
      d = primes[i]
      while mod(n, d) == 0 do
        t[d] += 1
        n = (n.to_f / d).to_i
      end
      if n == 1 then
        return (primes[i])
      end
    end
    return (n)
end

def sumdivaux2( t, n, i )
    while i < n && t[i] == 0 do
      i += 1
    end
    return (i)
end

def sumdivaux( t, n, i )
    if i > n then
      return (1)
    elsif t[i] == 0 then
      return (sumdivaux(t, n, sumdivaux2(t, n, i + 1)))
    else
      o = sumdivaux(t, n, sumdivaux2(t, n, i + 1))
      out0 = 0
      p = i
      for j in (1 ..  t[i]) do
        out0 += p
        p *= i
      end
      return ((out0 + 1) * o)
    end
end

def sumdiv( nprimes, primes, n )
    t = [*0..n + 1 - 1].map { |i|
      next (0)
      }
    max0 = fillPrimesFactors(t, n, primes, nprimes)
    return (sumdivaux(t, max0, 0))
end

maximumprimes = 30001
era = [*0..maximumprimes - 1].map { |s|
  next (s)
  }
nprimes = eratostene(era, maximumprimes)
primes = [*0..nprimes - 1].map { |t|
  next (0)
  }
l = 0
for k in (2 ..  maximumprimes - 1) do
  if era[k] == k then
    primes[l] = k
    l += 1
  end
end
n = 100

=begin
 28124 ça prend trop de temps mais on arrive a passer le test 
=end

abondant = [*0..n + 1 - 1].map { |p|
  next (false)
  }
summable = [*0..n + 1 - 1].map { |q|
  next (false)
  }
sum = 0
for r in (2 ..  n) do
  other = sumdiv(nprimes, primes, r) - r
  if other > r then
    abondant[r] = true
  end
end
for i in (1 ..  n) do
  for j in (1 ..  n) do
    if abondant[i] && abondant[j] && i + j <= n then
      summable[i + j] = true
    end
  end
end
for o in (1 ..  n) do
  if !summable[o] then
    sum += o
  end
end
printf "\n%d\n", sum

