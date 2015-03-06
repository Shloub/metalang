

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
La suite de fibonaci
--]]
function fibo( a, b, i )
  local out_ = 0
  local a2 = a
  local b2 = b
  for j = 0,i + 1 do
  io.write(j)
    out_ = out_ + a2;
    local tmp = b2
    b2 = b2 + a2;
    a2 = tmp;
    end
    return out_
  end
  
  
  io.write(fibo(1, 2, 4))
  