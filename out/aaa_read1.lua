
function readcharline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), ".") do
    tab[i] = string.byte(a)
    i = i + 1
  end
  return tab
end

local str = readcharline()
for i = 0,11 do
  io.write(string.format("%c", str[i]))
end
