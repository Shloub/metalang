import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def fact( n ):
    prod = 1
    for i in range(2, 1 + n):
      prod *= i
    return prod

def show( lim, nth ):
    t = [None] * lim
    for i in range(0, lim):
      t[i] = i
    pris = [None] * lim
    for j in range(0, lim):
      pris[j] = False
    for k in range(1, lim):
      n = fact(lim - k)
      nchiffre = math.trunc(nth / n)
      nth = mod(nth, n)
      for l in range(0, lim):
        if not (pris[l]):
          if nchiffre == 0:
            print("%d" % l, end='')
            pris[l] = True
          nchiffre -= 1
    for m in range(0, lim):
      if not (pris[m]):
        print("%d" % m, end='')
    print("")

show(10, 999999)

