import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def id( b ):
    return b;

def g( t, index ):
    t[index] = False;

a = [None] * 5
for i in range(0, 5):
  print("%d" % i, end='')
  a[i] = (mod(i, 2)) == 0;
c = a[0];
if c:
  print( "True", end='')
else:
  print( "False", end='')
print("")
g(id(a), 0);
d = a[0];
if d:
  print( "True", end='')
else:
  print( "False", end='')
print("")

