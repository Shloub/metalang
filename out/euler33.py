import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def max2( a, b ):
    return max(a, b);

def min2( a, b ):
    return min(a, b);

def pgcd( a, b ):
    c = min2(a, b);
    d = max2(a, b);
    reste = mod(d, c);
    if reste == 0:
      return c;
    else:
      return pgcd(c, reste);

top = 1;
bottom = 1;
for i in range(1, 1 + 9):
  for j in range(1, 1 + 9):
    for k in range(1, 1 + 9):
      if i != j and j != k:
        a = i * 10 + j;
        b = j * 10 + k;
        if a * k == i * b:
          print("%d/%d\n" % ( a, b ), end='')
          top *= a
          bottom *= b
print("%d/%d\n" % ( top, bottom ), end='')
p = pgcd(top, bottom);
print("pgcd=%d\n" % ( p ), end='')
e = math.trunc(bottom / p);
print("%d\n" % ( e ), end='')

