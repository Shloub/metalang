import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def periode( restes, len, a, b ):
    while (a != 0):
      chiffre = math.trunc(a / b)
      reste = mod(a, b)
      for i in range(0, len):
        if restes[i] == reste:
          return len - i
      restes[len] = reste
      len += 1
      a = reste * 10
    return 0

t = [None] * 1000
for j in range(0, 1000):
  t[j] = 0
m = 0
mi = 0
for i in range(1, 1 + 1000):
  p = periode(t, 0, 1, i)
  if p > m:
    mi = i
    m = p
print("%d\n%d\n" % ( mi, m ), end='')

