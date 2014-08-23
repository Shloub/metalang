import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def max2( a, b ):
    return max(a, b);

def primesfactors( n ):
    tab = [None] * (n + 1)
    for i in range(0, n + 1):
      tab[i] = 0;
    d = 2;
    while (n != 1 and d * d <= n):
      if (mod(n, d)) == 0:
        tab[d] = tab[d] + 1;
        n = math.trunc(n / d)
      else:
        d += 1
    tab[n] = tab[n] + 1;
    return tab;

lim = 20;
o = [None] * (lim + 1)
for m in range(0, lim + 1):
  o[m] = 0;
for i in range(1, 1 + lim):
  t = primesfactors(i);
  for j in range(1, 1 + i):
    o[j] = max2(o[j], t[j]);
product = 1;
for k in range(1, 1 + lim):
  for l in range(1, 1 + o[k]):
    product *= k
print("%d\n" % ( product ), end='')

