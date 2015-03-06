

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



function is_leap( year )
  return (math.mod(year, 400)) == 0 or
  ((math.mod(year, 100)) ~= 0 and (math.mod(year, 4)) == 0)
end

function ndayinmonth( month, year )
  if month == 0 then
    return 31
  elseif month == 1 then
    if is_leap(year)
    then
      return 29
    else
      return 28
    end
  elseif month == 2 then
    return 31
  elseif month == 3 then
    return 30
  elseif month == 4 then
    return 31
  elseif month == 5 then
    return 30
  elseif month == 6 then
    return 31
  elseif month == 7 then
    return 31
  elseif month == 8 then
    return 30
  elseif month == 9 then
    return 31
  elseif month == 10 then
    return 30
  elseif month == 11
  then
    return 31
  end
  return 0
end


local month = 0
local year = 1901
local dayofweek = 1
--[[ 01-01-1901 : mardi --]]
local count = 0
while year ~= 2001
do
local ndays = ndayinmonth(month, year)
dayofweek = math.mod(dayofweek + ndays, 7);
month = month + 1;
if month == 12
then
  month = 0;
  year = year + 1;
end
if (math.mod(dayofweek, 7)) == 6
then
  count = count + 1;
end
end
io.write(string.format("%d\n", count))
