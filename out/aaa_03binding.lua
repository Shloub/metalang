

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



function g( i )
  local j = i * 4
  if (math.mod(j, 2)) == 1
  then
    return 0
  end
  return j
end

function h( i )
  io.write(string.format("%d\n", i))
end


h(14);
local a = 4
local b = 5
io.write(a + b)
--[[ main --]]
h(15);
a = 2;
b = 1;
io.write(a + b)
