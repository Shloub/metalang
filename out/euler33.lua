
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end
function max2_( a, b )
  if a > b
  then
    return a
  else
    return b
  end
end

function min2_( a, b )
  if a < b
  then
    return a
  else
    return b
  end
end

function pgcd( a, b )
  local c = min2_(a, b)
  local d = max2_(a, b)
  local reste = math.mod(d, c)
  if reste == 0
  then
    return c
  else
    return pgcd(c, reste)
  end
end


local top = 1
local bottom = 1
for i = 1,9 do
for j = 1,9 do
for k = 1,9 do
if i ~= j and j ~= k
  then
    local a = i * 10 + j
    local b = j * 10 + k
    if a * k == i * b
    then
      io.write(string.format("%d/%d\n", a, b))
      top = top * a;
      bottom = bottom * b;
    end
  end
  end
  end
  end
  io.write(string.format("%d/%d\n", top, bottom))
  local p = pgcd(top, bottom)
  io.write(string.format("pgcd=%d\n%d\n", p, trunc(bottom / p)))
  