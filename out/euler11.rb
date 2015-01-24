require "scanf.rb"
def find( n, m, x, y, dx, dy )
    if x < 0 || x == 20 || y < 0 || y == 20 then
      return (-1);
    elsif n == 0 then
      return (1);
    else
      return (m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy));
    end
end

directions = [];
for i in (0 ..  8 - 1) do
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
max0 = 0
m = [*1..20].map { |l| STDIN.readline.split(" ").map{ |x| x.to_i(10) } }
for j in (0 ..  7) do
  (dx, dy) = directions[j]
  for x in (0 ..  19) do
    for y in (0 ..  19) do
      g = find(4, m, x, y, dx, dy)
      f = [max0, g].max
      max0 = f;
    end
  end
end
printf "%d\n", max0

