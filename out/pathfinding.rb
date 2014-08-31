require "scanf.rb"
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
      e = [val1, val2, val3, val4].min
      out_ = 1 + e
      cache[posY][posX] = out_;
      return (out_);
    end
end

def pathfind( tab, x, y )
    cache = [];
    for i in (0 ..  y - 1) do
      tmp = [];
      for j in (0 ..  x - 1) do
        tmp[j] = -1;
      end
      cache[i] = tmp;
    end
    return (pathfind_aux(cache, tab, x, y, 0, 0));
end

x = 0
y = 0
x=scanf("%d")[0];
scanf("%*\n");
y=scanf("%d")[0];
scanf("%*\n");
tab = [];
for i in (0 ..  y - 1) do
  tab2 = [];
  for j in (0 ..  x - 1) do
    tmp = "\000"
    tmp=scanf("%c")[0];
    tab2[j] = tmp;
  end
  scanf("%*\n");
  tab[i] = tab2;
end
result = pathfind(tab, x, y)
printf "%d", result

