import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def is_pair( i ):
    j = 1;
    if i < 10:
      j = 2;
      if i == 0:
        j = 4;
        return True;
      j = 3;
      if i == 2:
        j = 4;
        return True;
      j = 5;
    j = 6;
    if i < 20:
      if i == 22:
        j = 0;
      j = 8;
    return (mod(i, 2)) == 0;



