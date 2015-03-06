buffer =  ""
function readint()
    if buffer == "" then buffer = io.read("*line") end
    local num, buffer0 = string.match(buffer, '^([\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end

function stdinsep()
    if buffer == "" then buffer = io.read("*line") end
    if buffer ~= nil then buffer = string.gsub(buffer, '^%s*', "") end
end

for i = 1,3 do
local a = readint()
  stdinsep()
  local b = readint()
  stdinsep()
  io.write(string.format("a = %d b = %d\n", a, b))
  end
  local l = {}
  for c = 0,10 - 1 do
  l[c] = readint()
    stdinsep()
    end
    for j = 0,9 do
    io.write(string.format("%d\n", l[j]))
      end
      