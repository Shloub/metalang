import math
def mod(x, y):
    return x - y * math.trunc(x / y)


def eratostene(t, max0):
    n = 0
    for i in range(2, max0):
        if t[i] == i:
            n += 1
            j = i * i
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
def sumdivaux2(t, n, i):
    while i < n and t[i] == 0:
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
        for j in range(1, t[i] + 1):
            out0 += p
            p *= i
        return (out0 + 1) * o
def sumdiv(nprimes, primes, n):
    t = [0] * (n + 1)
    max0 = fillPrimesFactors(t, n, primes, nprimes)
    return sumdivaux(t, max0, 0)
maximumprimes = 30001
era = [None] * maximumprimes
for s in range(0, maximumprimes):
    era[s] = s
nprimes = eratostene(era, maximumprimes)
primes = [0] * nprimes
l = 0
for k in range(2, maximumprimes):
    if era[k] == k:
        primes[l] = k
        l += 1
n = 100
# 28124 ça prend trop de temps mais on arrive a passer le test 

abondant = [False] * (n + 1)
summable = [False] * (n + 1)
sum = 0
for r in range(2, n + 1):
    other = sumdiv(nprimes, primes, r) - r
    if other > r:
        abondant[r] = True
for i in range(1, n + 1):
    for j in range(1, n + 1):
        if abondant[i] and abondant[j] and i + j <= n:
            summable[i + j] = True
for o in range(1, n + 1):
    if not summable[o]:
        sum += o
print("\n%d\n" % sum, end='')

