

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



function eratostene( t, max0 )
  local n = 0
  for i = 2,max0 - 1 do
  if t[i] == i
    then
      n = n + 1;
      if trunc(max0 / i) > i
      then
        local j = i * i
        while j < max0 and j > 0
        do
        t[j] = 0;
        j = j + i;
        end
      end
    end
    end
    return n
  end
  
  
  local maximumprimes = 6000
  local era = {}
  for j_ = 0,maximumprimes - 1 do
  era[j_] = j_;
    end
    local nprimes = eratostene(era, maximumprimes)
    local primes = {}
    for o = 0,nprimes - 1 do
    primes[o] = 0;
      end
      local l = 0
      for k = 2,maximumprimes - 1 do
      if era[k] == k
        then
          primes[l] = k;
          l = l + 1;
        end
        end
        io.write(string.format("%d == %d\n", l, nprimes))
        local canbe = {}
        for i_ = 0,maximumprimes - 1 do
        canbe[i_] = false;
          end
          for i = 0,nprimes - 1 do
          for j = 0,maximumprimes - 1 do
          local n = primes[i] + 2 * j * j
            if n < maximumprimes
            then
              canbe[n] = true;
            end
            end
            end
            for m = 1,maximumprimes do
            local m2 = m * 2 + 1
              if m2 < maximumprimes and not(canbe[m2])
              then
                io.write(string.format("%d\n", m2))
              end
              end
              