

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



function id( b )
  return b
end

function g( t, index )
  t[index] = false;
end


local j = 0
local a = {}
for i = 0,5 - 1 do
io.write(i)
  j = j + i;
  a[i] = (math.mod(i, 2)) == 0;
  end
  io.write(string.format("%d ", j))
  local c = a[0]
  if c
  then
    io.write("True")
  else
    io.write("False")
  end
  io.write("\n")
  g(id(a), 0);
  local d = a[0]
  if d
  then
    io.write("True")
  else
    io.write("False")
  end
  io.write("\n")
  