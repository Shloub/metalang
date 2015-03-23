import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def chiffre_sort( a ):
    if a < 10:
      return a
    else:
      b = chiffre_sort(math.trunc(a / 10))
      c = mod(a, 10)
      d = mod(b, 10)
      e = math.trunc(b / 10)
      if c < d:
        return c + b * 10
      else:
        return d + chiffre_sort(c + e * 10) * 10

def same_numbers( a, b, c, d, e, f ):
    ca = chiffre_sort(a)
    return ca == chiffre_sort(b) and ca == chiffre_sort(c) and ca == chiffre_sort(d) and ca == chiffre_sort(e) and ca == chiffre_sort(f)

num = 142857
if same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5):
  print("%d %d %d %d %d %d\n" % ( num, (num * 2), (num * 3), (num * 4), (num * 5), (num * 6) ), end='')

