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
function max2_( a, b )
  if a > b
  then
    return a
  else
    return b
  end
end

function find( n, m, x, y, dx, dy )
  if x < 0 or x == 20 or y < 0 or y == 20 then
    return -1
  elseif n == 0
  then
    return 1
  else
    return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy)
  end
end



local directions = {}
for i = 0,8 - 1 do
if i == 0 then
    local c = {
      tuple_int_int_field_0=0,
      tuple_int_int_field_1=1
    }
    directions[i] = c;
  elseif i == 1 then
    local d = {
      tuple_int_int_field_0=1,
      tuple_int_int_field_1=0
    }
    directions[i] = d;
  elseif i == 2 then
    local e = {
      tuple_int_int_field_0=0,
      tuple_int_int_field_1=-1
    }
    directions[i] = e;
  elseif i == 3 then
    local f = {
      tuple_int_int_field_0=-1,
      tuple_int_int_field_1=0
    }
    directions[i] = f;
  elseif i == 4 then
    local g = {
      tuple_int_int_field_0=1,
      tuple_int_int_field_1=1
    }
    directions[i] = g;
  elseif i == 5 then
    local h = {
      tuple_int_int_field_0=1,
      tuple_int_int_field_1=-1
    }
    directions[i] = h;
  elseif i == 6
  then
    local k = {
      tuple_int_int_field_0=-1,
      tuple_int_int_field_1=1
    }
    directions[i] = k;
  else
    local l = {
      tuple_int_int_field_0=-1,
      tuple_int_int_field_1=-1
    }
    directions[i] = l;
  end
  end
  local max0 = 0
  local m = {}
  for o = 0,20 - 1 do
  local p = {}
    for q = 0,20 - 1 do
    p[q] = readint()
      stdinsep()
      end
      m[o] = p;
      end
      for j = 0,7 do
      local r = directions[j]
        local dx = r.tuple_int_int_field_0
        local dy = r.tuple_int_int_field_1
        for x = 0,19 do
        for y = 0,19 do
        max0 = max2_(max0, find(4, m, x, y, dx, dy));
          end
          end
          end
          io.write(string.format("%d\n", max0))
          