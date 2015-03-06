

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



function min2_( a, b )
  if a < b
  then
    return a
  else
    return b
  end
end

function pathfind_aux( cache, tab, x, y, posX, posY )
  if posX == x - 1 and posY == y - 1 then
    return 0
  elseif posX < 0 or posY < 0 or posX >= x or posY >= y then
    return x * y * 10
  elseif tab[posY][posX] == 35 then
    return x * y * 10
  elseif cache[posY][posX] ~= -1
  then
    return cache[posY][posX]
  else
    cache[posY][posX] = x * y * 10;
    local val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY)
    local val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY)
    local val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1)
    local val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1)
    local out0 = 1 + min2_(min2_(min2_(val1, val2), val3), val4)
    cache[posY][posX] = out0;
    return out0
  end
end

function pathfind( tab, x, y )
  local cache = {}
  for i = 0,y - 1 do
  local tmp = {}
    for j = 0,x - 1 do
    tmp[j] = -1;
      end
      cache[i] = tmp;
      end
      return pathfind_aux(cache, tab, x, y, 0, 0)
    end
    
    
    local x = 0
    local y = 0
    x = readint()
    stdinsep()
    y = readint()
    stdinsep()
    local tab = {}
    for i = 0,y - 1 do
    local tab2 = {}
      for j = 0,x - 1 do
      local tmp = 0
        tmp = readchar()
        tab2[j] = tmp;
        end
        stdinsep()
        tab[i] = tab2;
        end
        local result = pathfind(tab, x, y)
        io.write(result)
        