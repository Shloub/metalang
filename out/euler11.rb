require "scanf.rb"
def max2( a, b )
    if a > b then
      return (a);
    end
    return (b);
end

def read_int_line( n )
    tab = [];
    for i in (0 ..  n - 1) do
      t = 0
      t=scanf("%d")[0];
      scanf("%*\n");
      tab[i] = t;
    end
    return (tab);
end

def read_int_matrix( x, y )
    tab = [];
    for z in (0 ..  y - 1) do
      tab[z] = read_int_line(x);
    end
    return (tab);
end

def find( n, m, x, y, dx, dy )
    if x < 0 || x == 20 || y < 0 || y == 20 then
      return (-1);
    elsif n == 0 then
      return (1);
    else
      return (m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy));
    end
end

c = 8
directions = [];
for i in (0 ..  c - 1) do
  if i == 0 then
    directions[i] = [0, 1];
  elsif i == 1 then
    directions[i] = [1, 0];
  elsif i == 2 then
    directions[i] = [0, -1];
  elsif i == 3 then
    directions[i] = [-1, 0];
  elsif i == 4 then
    directions[i] = [1, 1];
  elsif i == 5 then
    directions[i] = [1, -1];
  elsif i == 6 then
    directions[i] = [-1, 1];
  else
    directions[i] = [-1, -1];
  end
end
max_ = 0
m = read_int_matrix(20, 20)
for j in (0 ..  7) do
  (dx, dy) = directions[j]
  for x in (0 ..  19) do
    for y in (0 ..  19) do
      max_ = max2(max_, find(4, m, x, y, dx, dy));
    end
  end
end
printf "%d\n", max_

