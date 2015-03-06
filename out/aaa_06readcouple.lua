
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
  local c = readintline()
  local a = c[0]
  local b = c[1]
  io.write(string.format("a = %d b = %d\n", a, b))
end
local l = readintline()
for j = 0,9 do
  io.write(string.format("%d\n", l[j]))
end
