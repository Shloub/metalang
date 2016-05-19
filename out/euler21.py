import math
def mod(x, y):
    return x - y * math.trunc(x / y)

def eratostene(t, max0):
    n = 0
    for i in range(2, max0):
        if t[i] == i:
            n += 1
            j = i * i
            while (j < max0 and j > 0):
                t[j] = 0
                j += i
    return n

def fillPrimesFactors(t, n, primes, nprimes):
    for i in range(0, nprimes):
        d = primes[i]
        while (mod(n, d) == 0):
            t[d] = t[d] + 1
            n = math.trunc(n / d)
        if n == 1:
            return primes[i]
    return n

def sumdivaux2(t, n, i):
    while (i < n and t[i] == 0):
        i += 1
    return i

def sumdivaux(t, n, i):
    if i > n:
        return 1
    elif t[i] == 0:
        return sumdivaux(t, n, sumdivaux2(t, n, i + 1))
    else:
        o = sumdivaux(t, n, sumdivaux2(t, n, i + 1))
        out0 = 0
        p = i
        for j in range(1, 1 + t[i]):
            out0 += p
            p *= i
        return (out0 + 1) * o

def sumdiv(nprimes, primes, n):
    t = [0] * (n + 1)
    max0 = fillPrimesFactors(t, n, primes, nprimes)
    return sumdivaux(t, max0, 0)

maximumprimes = 1001
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
print("%d == %d\n" % (l, nprimes), end='')
sum = 0
for n in range(2, 1 + 1000):
    other = sumdiv(nprimes, primes, n) - n
    if other > n:
        othersum = sumdiv(nprimes, primes, other) - other
        if othersum == n:
            print("%d & %d\n" % (other, n), end='')
            sum += other + n
print("\n%d\n" % (sum), end='')

