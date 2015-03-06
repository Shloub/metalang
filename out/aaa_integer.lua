

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



local i = 0
i = i - 1;
io.write(string.format("%d\n", i))
i = i + 55;
io.write(string.format("%d\n", i))
i = i * 13;
io.write(string.format("%d\n", i))
i = trunc(i / 2);
io.write(string.format("%d\n", i))
i = i + 1;
io.write(string.format("%d\n", i))
i = trunc(i / 3);
io.write(string.format("%d\n", i))
i = i - 1;
io.write(string.format("%d\n", i))
--[[
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
--]]
io.write(string.format("%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n", trunc(117 / 17), trunc(117 / -17), trunc(-117 / 17), trunc(-117 / -17), math.mod(117, 17), math.mod(117, -17), math.mod(-117, 17), math.mod(-117, -17)))
