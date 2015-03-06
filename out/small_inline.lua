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

local t = {}
for d = 0,2 - 1 do
  t[d] = readint()
  stdinsep()
end
io.write(string.format("%d - %d\n", t[0], t[1]))
