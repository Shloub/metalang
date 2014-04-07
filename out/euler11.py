def max2( a, b ):
    if a > b:
      return a;
    return b;


def read_int_matrix( x, y ):
    return [list(map(int, input().split())) for i in range(y)];

def find( n, m, x, y, dx, dy ):
    if x < 0 or x == 20 or y < 0 or y == 20:
      return -(1);
    elif n == 0:
      return 1;
    else:
      return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);

c = 8;
directions = [None] * c
for i in range(0, c):
  if i == 0:
    directions[i] = (0, 1);
  elif i == 1:
    directions[i] = (1, 0);
  elif i == 2:
    directions[i] = (0, -(1));
  elif i == 3:
    directions[i] = (-(1), 0);
  elif i == 4:
    directions[i] = (1, 1);
  elif i == 5:
    directions[i] = (1, -(1));
  elif i == 6:
    directions[i] = (-(1), 1);
  else:
    directions[i] = (-(1), -(1));
max_ = 0;
m = read_int_matrix(20, 20);
for j in range(0, 1 + 7):
  (dx, dy) = directions[j]
  for x in range(0, 1 + 19):
    for y in range(0, 1 + 19):
      max_ = max2(max_, find(4, m, x, y, dx, dy));
print("%d\n" % ( max_ ), end='')

