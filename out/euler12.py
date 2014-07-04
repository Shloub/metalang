import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def max2( a, b ):
    return max(a, b);

def eratostene( t, max_ ):
    n = 0;
    for i in range(2, max_):
      if t[i] == i:
        j = i * i;
        n += 1
        while (j < max_ and j > 0):
          t[j] = 0;
          j += i
    return n;

def fillPrimesFactors( t, n, primes, nprimes ):
    for i in range(0, nprimes):
      d = primes[i];
      while ((mod(n, d)) == 0):
        t[d] = t[d] + 1;
        n = math.trunc(n / d)
      if n == 1:
        return primes[i];
    return n;

def find( ndiv2 ):
    maximumprimes = 110;
    era = [None] * maximumprimes
    for j in range(0, maximumprimes):
      era[j] = j;
    nprimes = eratostene(era, maximumprimes);
    primes = [None] * nprimes
    for o in range(0, nprimes):
      primes[o] = 0;
    l = 0;
    for k in range(2, maximumprimes):
      if era[k] == k:
        primes[l] = k;
        l += 1
    for n in range(1, 1 + 10000):
      c = n + 2;
      primesFactors = [None] * c
      for m in range(0, c):
        primesFactors[m] = 0;
      max_ = max2(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes));
      primesFactors[2] -= 1
      ndivs = 1;
      for i in range(0, 1 + max_):
        if primesFactors[i] != 0:
          ndivs *= 1 + primesFactors[i]
      if ndivs > ndiv2:
        return math.trunc((n * (n + 1)) / 2);
      """ print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" """
    return 0;

e = find(500);
print("%d\n" % ( e ), end='')

