

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



local maximum = 1
local b0 = 2
local a = 408464633
local sqrtia = math.floor(math.sqrt(a))
while a ~= 1
do
local b = b0
local found = false
while b <= sqrtia
do
if (math.mod(a, b)) == 0
then
  a = trunc(a / b);
  b0 = b;
  b = a;
  sqrtia = math.floor(math.sqrt(a));
  found = true;
end
b = b + 1;
end
if not(found)
then
  io.write(string.format("%d\n", a))
  a = 1;
end
end
