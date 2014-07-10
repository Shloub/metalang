require "scanf.rb"
def min2( a, b )
    if a < b then
      return (a);
    else
      return (b);
    end
end

def min3( a, b, c )
    return (min2(min2(a, b), c));
end

def min4( a, b, c, d )
    f = min2(a, b)
    g = c
    h = d
    e = min2(min2(f, g), h)
    return (e);
end

def read_int(  )
    out_ = 0
    out_=scanf("%d")[0];
    scanf("%*\n");
    return (out_);
end

def read_char_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t = "_"
      t=scanf("%c")[0];
      tab[i] = t;
    end
    scanf("%*\n");
    return (tab);
end

def read_char_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      l = x
      m = [];
      for o in (0 ..  l - 1) do
        p = "_"
        p=scanf("%c")[0];
        m[o] = p;
      end
      scanf("%*\n");
      k = m
      tab[z] = k;
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
      r = val1
      s = val2
      u = val3
      v = val4
      w = min2(r, s)
      ba = u
      bb = v
      bc = min2(min2(w, ba), bb)
      q = bc
      out_ = 1 + q
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

be = 0
be=scanf("%d")[0];
scanf("%*\n");
bd = be
x = bd
bg = 0
bg=scanf("%d")[0];
scanf("%*\n");
bf = bg
y = bf
printf "%d %d\n", x, y
tab = read_char_matrix(x, y)
result = pathfind(tab, x, y)
printf "%d", result

