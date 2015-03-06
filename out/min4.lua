

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


io.write(string.format("%d %d %d %d %d %d\n%d %d %d %d %d %d\n%d %d %d %d %d %d\n%d %d %d %d %d %d\n", min2_(min2_(min2_(1, 2), 3), 4), min2_(min2_(min2_(1, 2), 4), 3), min2_(min2_(min2_(1, 3), 2), 4), min2_(min2_(min2_(1, 3), 4), 2), min2_(min2_(min2_(1, 4), 2), 3), min2_(min2_(min2_(1, 4), 3), 2), min2_(min2_(min2_(2, 1), 3), 4), min2_(min2_(min2_(2, 1), 4), 3), min2_(min2_(min2_(2, 3), 1), 4), min2_(min2_(min2_(2, 3), 4), 1), min2_(min2_(min2_(2, 4), 1), 3), min2_(min2_(min2_(2, 4), 3), 1), min2_(min2_(min2_(3, 1), 2), 4), min2_(min2_(min2_(3, 1), 4), 2), min2_(min2_(min2_(3, 2), 1), 4), min2_(min2_(min2_(3, 2), 4), 1), min2_(min2_(min2_(3, 4), 1), 2), min2_(min2_(min2_(3, 4), 2), 1), min2_(min2_(min2_(4, 1), 2), 3), min2_(min2_(min2_(4, 1), 3), 2), min2_(min2_(min2_(4, 2), 1), 3), min2_(min2_(min2_(4, 2), 3), 1), min2_(min2_(min2_(4, 3), 1), 2), min2_(min2_(min2_(4, 3), 2), 1)))
