

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



function h( i )
  --[[  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end --]]
  local j = i - 2
  while j <= i + 2
  do
  if (math.mod(i, j)) == 5
  then
    return true
  end
  j = j + 1;
  end
  return false
end


local j = 0
for k = 0,10 do
j = j + k;
  io.write(string.format("%d\n", j))
  end
  local i = 4
  while i < 10
  do
  io.write(i)
  i = i + 1;
  j = j + i;
  end
  io.write(string.format("%d%dFIN TEST\n", j, i))
  