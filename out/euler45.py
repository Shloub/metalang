import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def triangle( n ):
    if (mod(n, 2)) == 0:
      return (math.trunc(n / 2)) * (n + 1)
    else:
      return n * (math.trunc((n + 1) / 2))

def penta( n ):
    if (mod(n, 2)) == 0:
      return (math.trunc(n / 2)) * (3 * n - 1)
    else:
      return (math.trunc((3 * n - 1) / 2)) * n

def hexa( n ):
    return n * (2 * n - 1)

def findPenta2( n, a, b ):
    if b == a + 1:
      return penta(a) == n or penta(b) == n
    c = math.trunc((a + b) / 2)
    p = penta(c)
    if p == n:
      return True
    elif p < n:
      return findPenta2(n, c, b)
    else:
      return findPenta2(n, a, c)

def findHexa2( n, a, b ):
    if b == a + 1:
      return hexa(a) == n or hexa(b) == n
    c = math.trunc((a + b) / 2)
    p = hexa(c)
    if p == n:
      return True
    elif p < n:
      return findHexa2(n, c, b)
    else:
      return findHexa2(n, a, c)

for n in range(285, 1 + 55385):
  t = triangle(n)
  if findPenta2(t, math.trunc(n / 5), n) and findHexa2(t, math.trunc(n / 5), math.trunc(n / 2) + 10):
    print("%d\n%d\n" % ( n, t ), end='')

