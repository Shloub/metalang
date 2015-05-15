require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end
def eratostene( t, max0 )
    n = 0
    for i in (2 ..  max0 - 1) do
      if t[i] == i then
        j = i * i
        n += 1
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
        t[d] = t[d] + 1
        n = (n.to_f / d).to_i
      end
      if n == 1 then
        return (primes[i])
      end
    end
    return (n)
end

def find( ndiv2 )
    maximumprimes = 110
    era = [*0..maximumprimes - 1].map { |j|
      next (j)
      }
    nprimes = eratostene(era, maximumprimes)
    primes = [*0..nprimes - 1].map { |o|
      next (0)
      }
    l = 0
    for k in (2 ..  maximumprimes - 1) do
      if era[k] == k then
        primes[l] = k
        l += 1
      end
    end
    for n in (1 ..  10000) do
      primesFactors = [*0..n + 2 - 1].map { |m|
        next (0)
        }
      max0 = [fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes)].max
      primesFactors[2] -= 1
      ndivs = 1
      for i in (0 ..  max0) do
        if primesFactors[i] != 0 then
          ndivs *= 1 + primesFactors[i]
        end
      end
      if ndivs > ndiv2 then
        return ((n * (n + 1).to_f / 2).to_i)
      end
      
=begin
 print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" 
=end

    end
    return (0)
end

printf "%d\n", find(500)

