def min4( a, b, c, d ):
    return min(a, b, c, d);

def read_int(  ):
    return int(input());

def read_char_line( n ):
    return list(input());

def read_char_matrix( x, y ):
    tab = [None] * y
    for z in range(0, y):
      tab[z] = read_char_line(x);
    return tab;

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
      out_ = 1 + min4(val1, val2, val3, val4);
      cache[posY][posX] = out_;
      return out_;

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

x = read_int();
y = read_int();
print("%d %d\n" % ( x, y ), end='')
tab = read_char_matrix(x, y);
result = pathfind(tab, x, y);
print("%d" % result, end='')

