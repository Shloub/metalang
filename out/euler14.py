import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def next0( n ):
    if (mod(n, 2)) == 0:
      return math.trunc(n / 2)
    else:
      return 3 * n + 1

def find( n, m ):
    if n == 1:
      return 1
    elif n >= 1000000:
      return 1 + find(next0(n), m)
    elif m[n] != 0:
      return m[n]
    else:
      m[n] = 1 + find(next0(n), m)
      return m[n]

m = [None] * 1000000
for j in range(0, 1000000):
  m[j] = 0
max0 = 0
maxi = 0
for i in range(1, 1 + 999):
  """ normalement on met 999999 mais ça dépasse les int32... """
  n2 = find(i, m)
  if n2 > max0:
    max0 = n2
    maxi = i
print("%d\n%d\n" % ( max0, maxi ), end='')

