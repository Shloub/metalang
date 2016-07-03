import math
def mod(x, y):
    return x - y * math.trunc(x / y)


def eratostene(t, max0):
    n = 0
    for i in range(2, max0):
        if t[i] == i:
            j = i * i
            n += 1
            while j < max0 and j > 0:
                t[j] = 0
                j += i
    return n

def fillPrimesFactors(t, n, primes, nprimes):
    for i in range(0, nprimes):
        d = primes[i]
        while mod(n, d) == 0:
            t[d] += 1
            n = math.trunc(n / d)
        if n == 1:
            return primes[i]
    return n

def find(ndiv2):
    maximumprimes = 110
    era = [None] * maximumprimes
    for j in range(0, maximumprimes):
        era[j] = j
    nprimes = eratostene(era, maximumprimes)
    primes = [0] * nprimes
    l = 0
    for k in range(2, maximumprimes):
        if era[k] == k:
            primes[l] = k
            l += 1
    for n in range(1, 10001):
        primesFactors = [0] * (n + 2)
        max0 = max(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes))
        primesFactors[2] -= 1
        ndivs = 1
        for i in range(0, max0 + 1):
            if primesFactors[i] != 0:
                ndivs *= 1 + primesFactors[i]
        if ndivs > ndiv2:
            return math.trunc(n * (n + 1) / 2)
        # print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" 
        
    return 0

print("%d\n" % find(500), end='')

