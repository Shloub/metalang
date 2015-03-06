buffer =  ""
function readint()
    if buffer == "" then buffer = io.read("*line") end
    local num, buffer0 = string.match(buffer, '^([\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end

function stdinsep()
    if buffer == "" then buffer = io.read("*line") end
    if buffer ~= nil then buffer = string.gsub(buffer, '^%s*', "") end
end
function montagnes0( tab, len )
  local max0 = 1
  local j = 1
  local i = len - 2
  while i >= 0
  do
  local x = tab[i]
  while j >= 0 and x > tab[len - j]
  do
  j = j - 1;
  end
  j = j + 1;
  tab[len - j] = x;
  if j > max0
  then
    max0 = j;
  end
  i = i - 1;
  end
  return max0
end


local len = 0
len = readint()
stdinsep()
local tab = {}
for i = 0,len - 1 do
local x = 0
  x = readint()
  stdinsep()
  tab[i] = x;
  end
  io.write(montagnes0(tab, len))
  