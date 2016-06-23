import math

def eratostene(t, max0):
    n = 0
    for i in range(2, 1 + max0 - 1):
        if t[i] == i:
            n += 1
            if math.trunc(max0 / i) > i:
                j = i * i
                while j < max0 and j > 0:
                    t[j] = 0
                    j += i
    return n

maximumprimes = 6000
era = [None] * maximumprimes
for j_ in range(0, 1 + maximumprimes - 1):
    era[j_] = j_
nprimes = eratostene(era, maximumprimes)
primes = [0] * nprimes
l = 0
for k in range(2, 1 + maximumprimes - 1):
    if era[k] == k:
        primes[l] = k
        l += 1
print("%d == %d\n" % (l, nprimes), end='')
canbe = [False] * maximumprimes
for i in range(0, 1 + nprimes - 1):
    for j in range(0, 1 + maximumprimes - 1):
        n = primes[i] + 2 * j * j
        if n < maximumprimes:
            canbe[n] = True
for m in range(1, 1 + maximumprimes):
    m2 = m * 2 + 1
    if m2 < maximumprimes and not canbe[m2]:
        print("%d\n" % m2, end='')

