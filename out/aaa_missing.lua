
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), "-?%d+") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end
--[[
  Ce test a été généré par Metalang.
--]]
function result( len, tab )
  local tab2 = {}
  for i = 0,len - 1 do
    tab2[i] = false;
  end
  for i1 = 0,len - 1 do
    io.write(string.format("%d ", tab[i1]))
    tab2[tab[i1]] = true;
  end
  io.write("\n")
  for i2 = 0,len - 1 do
    if not(tab2[i2])
    then
      return i2
    end
  end
  return -1
end


local len = tonumber(io.read('*l'))
io.write(string.format("%d\n", len))
local tab = readintline()
io.write(string.format("%d\n", result(len, tab)))
