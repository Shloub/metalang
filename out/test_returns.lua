

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



function is_pair( i )
  local j = 1
  if i < 10
  then
    j = 2;
    if i == 0
    then
      j = 4;
      return true
    end
    j = 3;
    if i == 2
    then
      j = 4;
      return true
    end
    j = 5;
  end
  j = 6;
  if i < 20
  then
    if i == 22
    then
      j = 0;
    end
    j = 8;
  end
  return (math.mod(i, 2)) == 0
end



