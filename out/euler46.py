import math
def eratostene( t, max0 ):
    n = 0
    for i in range(2, max0):
      if t[i] == i:
        n += 1
        if math.trunc(max0 / i) > i:
          j = i * i
          while (j < max0 and j > 0):
            t[j] = 0
            j += i
    return n

maximumprimes = 6000
era = [None] * maximumprimes
for j_ in range(0, maximumprimes):
  era[j_] = j_
nprimes = eratostene(era, maximumprimes)
primes = [None] * nprimes
for o in range(0, nprimes):
  primes[o] = 0
l = 0
for k in range(2, maximumprimes):
  if era[k] == k:
    primes[l] = k
    l += 1
print("%d == %d\n" % ( l, nprimes ), end='')
canbe = [None] * maximumprimes
for i_ in range(0, maximumprimes):
  canbe[i_] = False
for i in range(0, nprimes):
  for j in range(0, maximumprimes):
    n = primes[i] + 2 * j * j
    if n < maximumprimes:
      canbe[n] = True
for m in range(1, 1 + maximumprimes):
  m2 = m * 2 + 1
  if m2 < maximumprimes and not (canbe[m2]):
    print("%d\n" % ( m2 ), end='')

