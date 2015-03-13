require "scanf.rb"
x = STDIN.readline.to_i(10)
y = STDIN.readline.to_i(10)
tab = [*1..y].map { |l| STDIN.readline.split(" ").map{ |x| x.to_i(10) } }
for ix in (1 ..  x - 1) do
  for iy in (1 ..  y - 1) do
    if tab[iy][ix] == 1 then
      tab[iy][ix] = [tab[iy][ix - 1], tab[iy - 1][ix], tab[iy - 1][ix - 1]].min + 1
    end
  end
end
for jy in (0 ..  y - 1) do
  for jx in (0 ..  x - 1) do
    printf "%d ", tab[jy][jx]
  end
  print "\n"
end

