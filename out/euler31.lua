
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end
function result( sum, t, maxIndex, cache )
  if cache[sum + 1][maxIndex + 1] ~= 0 then
    return cache[sum + 1][maxIndex + 1]
  elseif sum == 0 or maxIndex == 0
  then
    return 1
  else
    local out0 = 0
    local div = trunc(sum / t[maxIndex + 1])
    for i = 0,div do
      out0 = out0 + result(sum - i * t[maxIndex + 1], t, maxIndex - 1, cache);
    end
    cache[sum + 1][maxIndex + 1] = out0;
    return out0
  end
end


local t = {}
for i = 0,8 - 1 do
  t[i + 1] = 0;
end
t[0 + 1] = 1;
t[1 + 1] = 2;
t[2 + 1] = 5;
t[3 + 1] = 10;
t[4 + 1] = 20;
t[5 + 1] = 50;
t[6 + 1] = 100;
t[7 + 1] = 200;
local cache = {}
for j = 0,201 - 1 do
  local o = {}
  for k = 0,8 - 1 do
    o[k + 1] = 0;
  end
  cache[j + 1] = o;
end
io.write(result(200, t, 7, cache))
