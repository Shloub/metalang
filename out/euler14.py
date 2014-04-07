import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def next_( n ):
    if (mod(n, 2)) == 0:
      return math.trunc(n / 2);
    else:
      return 3 * n + 1;

def find( n, m ):
    if n == 1:
      return 1;
    elif n >= 1000000:
      return 1 + find(next_(n), m);
    elif m[n] != 0:
      return m[n];
    else:
      m[n] = 1 + find(next_(n), m);
      return m[n];

a = 1000000;
m = [None] * a
for j in range(0, a):
  m[j] = 0;
max_ = 0;
maxi = 0;
for i in range(1, 1 + 999):
  """ normalement on met 999999 mais ça dépasse les int32... """
  n2 = find(i, m);
  if n2 > max_:
    max_ = n2;
    maxi = i;
print("%d\n%d\n" % ( max_, maxi ), end='')

