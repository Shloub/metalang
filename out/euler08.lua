

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



function max2_( a, b )
  if a > b
  then
    return a
  else
    return b
  end
end


local i = 1
local last = {}
for j = 0,5 - 1 do
local c = readchar()
  local d = c - 48
  i = i * d;
  last[j] = d;
  end
  local max0 = i
  local index = 0
  local nskipdiv = 0
  for k = 1,995 do
  local e = readchar()
    local f = e - 48
    if f == 0
    then
      i = 1;
      nskipdiv = 4;
    else
      i = i * f;
      if nskipdiv < 0
      then
        i = trunc(i / last[index]);
      end
      nskipdiv = nskipdiv - 1;
    end
    last[index] = f;
    index = math.mod(index + 1, 5);
    max0 = max2_(max0, i);
    end
    io.write(string.format("%d\n", max0))
    