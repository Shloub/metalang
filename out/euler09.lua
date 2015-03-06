

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
	a + b + c = 1000 && a * a + b * b = c * c
	--]]
for a = 1,1000 do
for b = a + 1,1000 do
local c = 1000 - a - b
  local a2b2 = a * a + b * b
  local cc = c * c
  if cc == a2b2 and c > a
  then
    io.write(string.format("%d\n%d\n%d\n%d\n", a, b, c, a * b * c))
  end
  end
  end
  