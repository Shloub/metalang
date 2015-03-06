
function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end
--[[
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.


(a * 10 + b) ( c * 100 + d * 10 + e) =
  a * c * 1000 +
  a * d * 100 +
  a * e * 10 +
  b * c * 100 +
  b * d * 10 +
  b * e
  => b != e != b * e % 10 ET
  a != d != (b * e / 10 + b * d + a * e ) % 10
--]]
function okdigits( ok, n )
  if n == 0
  then
    return true
  else
    local digit = math.mod(n, 10)
    if ok[digit]
    then
      ok[digit] = false;
      local o = okdigits(ok, trunc(n / 10))
      ok[digit] = true;
      return o
    else
      return false
    end
  end
end


local count = 0
local allowed = {}
for i = 0,10 - 1 do
  allowed[i] = i ~= 0;
end
local counted = {}
for j = 0,100000 - 1 do
  counted[j] = false;
end
for e = 1,9 do
  allowed[e] = false;
  for b = 1,9 do
    if allowed[b]
    then
      allowed[b] = false;
      local be = math.mod(b * e, 10)
      if allowed[be]
      then
        allowed[be] = false;
        for a = 1,9 do
          if allowed[a]
          then
            allowed[a] = false;
            for c = 1,9 do
              if allowed[c]
              then
                allowed[c] = false;
                for d = 1,9 do
                  if allowed[d]
                  then
                    allowed[d] = false;
                    --[[ 2 * 3 digits --]]
                    local product = (a * 10 + b) * (c * 100 + d * 10 + e)
                    if not(counted[product]) and okdigits(allowed,
                    trunc(product / 10))
                    then
                      counted[product] = true;
                      count = count + product;
                      io.write(string.format("%d ", product))
                    end
                    --[[ 1  * 4 digits --]]
                    local product2 = b * (a * 1000 + c * 100 + d * 10 + e)
                    if not(counted[product2]) and okdigits(allowed,
                    trunc(product2 / 10))
                    then
                      counted[product2] = true;
                      count = count + product2;
                      io.write(string.format("%d ", product2))
                    end
                    allowed[d] = true;
                  end
                end
                allowed[c] = true;
              end
            end
            allowed[a] = true;
          end
        end
        allowed[be] = true;
      end
      allowed[b] = true;
    end
  end
  allowed[e] = true;
end
io.write(string.format("%d\n", count))
