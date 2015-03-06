

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



function divisible( n, t, size )
  for i = 0,size - 1 do
  if (math.mod(n, t[i])) == 0
    then
      return true
    end
    end
    return false
  end
  
  function find( n, t, used, nth )
    while used ~= nth
    do
    if divisible(n, t, used)
    then
      n = n + 1;
    else
      t[used] = n;
      n = n + 1;
      used = used + 1;
    end
    end
    return t[used - 1]
  end
  
  
  local n = 10001
  local t = {}
  for i = 0,n - 1 do
  t[i] = 2;
    end
    io.write(string.format("%d\n", find(3, t, 1, n)))
    