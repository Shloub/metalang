require "scanf.rb"
def find( n, m, x, y, dx, dy )
  if x < 0 || x == 20 || y < 0 || y == 20 then
      return -1
  elsif n == 0 then
      return 1
  else 
      return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy)
  end
end
directions = [*0..8-1].map { |i|
  
  if i == 0 then
      next [0, 1]
  elsif i == 1 then
      next [1, 0]
  elsif i == 2 then
      next [0, -1]
  elsif i == 3 then
      next [-1, 0]
  elsif i == 4 then
      next [1, 1]
  elsif i == 5 then
      next [1, -1]
  elsif i == 6 then
      next [-1, 1]
  else 
      next [-1, -1]
  end
  }
max0 = 0
m = [*1..20].map { |l| STDIN.readline.split(" ").map{ |x| x.to_i(10) } }
for j in (0 ..  7) do
    (dx, dy) = directions[j]
    for x in (0 ..  19) do
        for y in (0 ..  19) do
            max0 = [max0, find(4, m, x, y, dx, dy)].max
            end
            end
            end
            printf "%d\n", max0
            