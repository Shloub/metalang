require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

def max2( a, b )
    if a > b then
      return (a);
    else
      return (b);
    end
end

def eratostene( t, max_ )
    n = 0
    for i in (2 ..  max_ - 1) do
      if t[i] == i then
        j = i * i
        n += 1
        while j < max_ && j > 0 do
          t[j] = 0;
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
        t[d] = t[d] + 1;
        n = (n.to_f / d).to_i
      end
      if n == 1 then
        return (primes[i]);
      end
    end
    return (n);
end

def find( ndiv2 )
    maximumprimes = 110
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
    for n in (1 ..  10000) do
      c = n + 2
      primesFactors = [];
      for m in (0 ..  c - 1) do
        primesFactors[m] = 0;
      end
      max_ = max2(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes))
      primesFactors[2] -= 1
      ndivs = 1
      for i in (0 ..  max_) do
        if primesFactors[i] != 0 then
          ndivs *= 1 + primesFactors[i]
        end
      end
      if ndivs > ndiv2 then
        return (((n * (n + 1)).to_f / 2).to_i);
      end
      
=begin
 print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" 
=end

    end
    return (0);
end

e = find(500)
printf "%d\n", e

