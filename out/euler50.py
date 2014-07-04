import math
def min2( a, b ):
    return min(a, b);

def eratostene( t, max_ ):
    n = 0;
    for i in range(2, max_):
      if t[i] == i:
        n += 1
        j = i * i;
        if math.trunc(j / i) == i:
          """ overflow test """
          while (j < max_ and j > 0):
            t[j] = 0;
            j += i
    return n;

maximumprimes = 1000001;
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
print("%d == %d\n" % ( l, nprimes ), end='')
sum = [None] * nprimes
for i_ in range(0, nprimes):
  sum[i_] = primes[i_];
maxl = 0;
process = True;
stop = maximumprimes - 1;
len = 1;
resp = 1;
while (process):
  process = False;
  for i in range(0, 1 + stop):
    if i + len < nprimes:
      sum[i] = sum[i] + primes[i + len];
      if maximumprimes > sum[i]:
        process = True;
        if era[sum[i]] == sum[i]:
          maxl = len;
          resp = sum[i];
      else:
        stop = min2(stop, i);
  len += 1
print("%d\n%d\n" % ( resp, maxl ), end='')

