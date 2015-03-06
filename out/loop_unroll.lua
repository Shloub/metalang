

function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end

buffer =  ""
function readint()
    if buffer == "" then buffer = io.read("*line") end
    local num, buffer0 = string.match(buffer, '^([\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end

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


--[[
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
--]]

local j = 0
j = 0;
io.write(string.format("%d\n", j))
j = 1;
io.write(string.format("%d\n", j))
j = 2;
io.write(string.format("%d\n", j))
j = 3;
io.write(string.format("%d\n", j))
j = 4;
io.write(string.format("%d\n", j))
