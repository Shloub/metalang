
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), "-?%d+") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end

local len = tonumber(io.read('*l'))
io.write(string.format("%d=len\n", len))
local tab1 = readintline()
for i = 0,len - 1 do
  io.write(string.format("%d=>%d\n", i, tab1[i]))
end
len = tonumber(io.read('*l'));
local tab2 = {}
for a = 0,len - 1 - 1 do
  tab2[a] = readintline();
end
for i = 0,len - 2 do
  for j = 0,len - 1 do
    io.write(string.format("%d ", tab2[i][j]))
  end
  io.write("\n")
end
