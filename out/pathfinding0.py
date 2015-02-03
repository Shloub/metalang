def pathfind_aux( cache, tab, x, y, posX, posY ):
    if posX == x - 1 and posY == y - 1:
      return 0;
    elif posX < 0 or posY < 0 or posX >= x or posY >= y:
      return x * y * 10;
    elif tab[posY][posX] == '#':
      return x * y * 10;
    elif cache[posY][posX] != -(1):
      return cache[posY][posX];
    else:
      cache[posY][posX] = x * y * 10;
      val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
      val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
      val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
      val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
      out0 = 1 + min(val1, val2, val3, val4);
      cache[posY][posX] = out0;
      return out0;

def pathfind( tab, x, y ):
    cache = [None] * y
    for i in range(0, y):
      tmp = [None] * x
      for j in range(0, x):
        print("%c" % tab[i][j], end='')
        tmp[j] = -(1);
      print("")
      cache[i] = tmp;
    return pathfind_aux(cache, tab, x, y, 0, 0);

x = int(input());
y = int(input());
print("%d %d\n" % ( x, y ), end='')
l = [None] * y
for m in range(0, y):
  l[m] = list(input());
tab = l;
result = pathfind(tab, x, y);
print("%d" % result, end='')

