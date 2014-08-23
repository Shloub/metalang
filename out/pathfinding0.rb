require "scanf.rb"
def min2( a, b )
    if a < b then
      return (a);
    else
      return (b);
    end
end

def read_char_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      h = [];
      for k in (0 ..  x - 1) do
        l = "_"
        l=scanf("%c")[0];
        h[k] = l;
      end
      scanf("%*\n");
      g = h
      tab[z] = g;
    end
    return (tab);
end

def pathfind_aux( cache, tab, x, y, posX, posY )
    if posX == x - 1 && posY == y - 1 then
      return (0);
    elsif posX < 0 || posY < 0 || posX >= x || posY >= y then
      return (x * y * 10);
    elsif tab[posY][posX] == "#" then
      return (x * y * 10);
    elsif cache[posY][posX] != -1 then
      return (cache[posY][posX]);
    else
      cache[posY][posX] = x * y * 10;
      val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY)
      val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY)
      val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1)
      val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1)
      o = min2(val1, val2)
      p = min2(min2(o, val3), val4)
      m = p
      out_ = 1 + m
      cache[posY][posX] = out_;
      return (out_);
    end
end

def pathfind( tab, x, y )
    cache = [];
    for i in (0 ..  y - 1) do
      tmp = [];
      for j in (0 ..  x - 1) do
        printf "%c", tab[i][j]
        tmp[j] = -1;
      end
      print "\n";
      cache[i] = tmp;
    end
    return (pathfind_aux(cache, tab, x, y, 0, 0));
end

r = 0
r=scanf("%d")[0];
scanf("%*\n");
x = r
u = 0
u=scanf("%d")[0];
scanf("%*\n");
y = u
printf "%d %d\n", x, y
tab = read_char_matrix(x, y)
result = pathfind(tab, x, y)
printf "%d", result

