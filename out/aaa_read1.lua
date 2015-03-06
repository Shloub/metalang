buffer =  ""
function readchar()
    if buffer == "" then buffer = io.read("*line") end
    local c = string.byte(buffer)
    buffer = string.sub(buffer, 2, -1)
    return c
end

function stdinsep()
    if buffer == "" then buffer = io.read("*line") end
    if buffer ~= nil then buffer = string.gsub(buffer, '^%s*', "") end
end

local str = {}
for a = 0,12 - 1 do
str[a] = readchar()
  end
  stdinsep()
  for i = 0,11 do
  io.write(string.format("%c", str[i]))
    end
    