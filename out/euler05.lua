

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



function max2_( a, b )
  if a > b
  then
    return a
  else
    return b
  end
end

function primesfactors( n )
  local tab = {}
  for i = 0,n + 1 - 1 do
  tab[i] = 0;
    end
    local d = 2
    while n ~= 1 and d * d <= n
    do
    if (math.mod(n, d)) == 0
    then
      tab[d] = tab[d] + 1;
      n = trunc(n / d);
    else
      d = d + 1;
    end
    end
    tab[n] = tab[n] + 1;
    return tab
  end
  
  
  local lim = 20
  local o = {}
  for m = 0,lim + 1 - 1 do
  o[m] = 0;
    end
    for i = 1,lim do
    local t = primesfactors(i)
      for j = 1,i do
      o[j] = max2_(o[j], t[j]);
        end
        end
        local product = 1
        for k = 1,lim do
        for l = 1,o[k] do
        product = product * k;
          end
          end
          io.write(string.format("%d\n", product))
          