
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), "-?%d+") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end


local bar_ = tonumber(io.read('*l'))
local c = readintline()
local t = {foo={c[0], c[1]},
           bar=bar_}
a, b = unpack(t.foo)
io.write(string.format("%d %d %d\n", a, b, t.bar))
