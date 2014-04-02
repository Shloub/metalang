import math
def mod(x, y):
  return x - y * math.trunc(x / y)

maximum = 1;
b0 = 2;
a = 408464633;
while (a != 1):
  b = b0;
  found = False;
  while (b * b < a):
    if (mod(a, b)) == 0:
      a /= b
      b0 = b;
      b = a;
      found = True;
    b += 1
  if not (found):
    print("%d\n" % ( a ), end='')
    a = 1;

