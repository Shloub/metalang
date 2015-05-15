
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end

local lim = 100
local sum = trunc(lim * (lim + 1) / 2)
local carressum = sum * sum
local sumcarres = trunc(lim * (lim + 1) * (2 * lim + 1) / 6)
io.write(carressum - sumcarres)
