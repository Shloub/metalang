
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), "-?%d+") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end

for i = 1,3 do
  local d = readintline()
  local a = d[0]
  local b = d[1]
  local c = d[2]
  io.write(string.format("a = %d b = %dc =%d\n", a, b, c))
end
local l = readintline()
for j = 0,9 do
  io.write(string.format("%d\n", l[j]))
end
