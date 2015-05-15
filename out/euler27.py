import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def eratostene( t, max0 ):
    n = 0
    for i in range(2, max0):
      if t[i] == i:
        n += 1
        j = i * i
        while (j < max0 and j > 0):
          t[j] = 0
          j += i
    return n

def isPrime( n, primes, len ):
    i = 0
    if n < 0:
      n = -n
    while (primes[i] * primes[i] < n):
      if mod(n, primes[i]) == 0:
        return False
      i += 1
    return True

def test( a, b, primes, len ):
    for n in range(0, 1 + 200):
      j = n * n + a * n + b
      if not isPrime(j, primes, len):
        return n
    return 200

maximumprimes = 1000
era = [None] * maximumprimes
for j in range(0, maximumprimes):
  era[j] = j
result = 0
max0 = 0
nprimes = eratostene(era, maximumprimes)
primes = [0] * nprimes
l = 0
for k in range(2, maximumprimes):
  if era[k] == k:
    primes[l] = k
    l += 1
print("%d == %d\n" % ( l, nprimes ), end='')
ma = 0
mb = 0
for b in range(3, 1 + 999):
  if era[b] == b:
    for a in range(-999, 1 + 999):
      n1 = test(a, b, primes, nprimes)
      n2 = test(a, -b, primes, nprimes)
      if n1 > max0:
        max0 = n1
        result = a * b
        ma = a
        mb = b
      if n2 > max0:
        max0 = n2
        result = -a * b
        ma = a
        mb = -b
print("%d %d\n%d\n%d\n" % ( ma, mb, max0, result ), end='')

