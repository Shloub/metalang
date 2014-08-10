import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def id( b ):
    return b;

def g( t, index ):
    t[index] = False;

c = 5;
a = [None] * c
for i in range(0, c):
  print("%d" % i, end='')
  a[i] = (mod(i, 2)) == 0;
d = a[0];
if d:
  print( "True", end='')
else:
  print( "False", end='')
print("")
g(id(a), 0);
e = a[0];
if e:
  print( "True", end='')
else:
  print( "False", end='')
print("")

