
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), "-?%d+") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end

local x = tonumber(io.read('*l'))
local y = tonumber(io.read('*l'))
local tab = {}
for d = 0,y - 1 do
  tab[d] = readintline();
end
for ix = 1,x - 1 do
  for iy = 1,y - 1 do
    if tab[iy][ix] == 1
    then
      tab[iy][ix] =
      math.min(tab[iy][ix - 1], tab[iy - 1][ix], tab[iy - 1][ix - 1]) + 1;
    end
  end
end
for jy = 0,y - 1 do
  for jx = 0,x - 1 do
    io.write(string.format("%d ", tab[jy][jx]))
  end
  io.write("\n")
end
