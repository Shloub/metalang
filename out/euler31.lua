
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end
function result( sum, t, maxIndex, cache )
  if cache[sum][maxIndex] ~= 0 then
    return cache[sum][maxIndex]
  elseif sum == 0 or maxIndex == 0
  then
    return 1
  else
    local out0 = 0
    local div = trunc(sum / t[maxIndex])
    for i = 0,div do
    out0 = out0 + result(sum - i * t[maxIndex], t, maxIndex - 1, cache);
      end
      cache[sum][maxIndex] = out0;
      return out0
    end
  end
  
  
  local t = {}
  for i = 0,8 - 1 do
  t[i] = 0;
    end
    t[0] = 1;
    t[1] = 2;
    t[2] = 5;
    t[3] = 10;
    t[4] = 20;
    t[5] = 50;
    t[6] = 100;
    t[7] = 200;
    local cache = {}
    for j = 0,201 - 1 do
    local o = {}
      for k = 0,8 - 1 do
      o[k] = 0;
        end
        cache[j] = o;
        end
        io.write(result(200, t, 7, cache))
        