

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


--[[ Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
--]]
function find0( len, tab, cache, x, y )
  --[[
	Cette fonction est récursive
	--]]
  if y == len - 1 then
    return tab[y][x]
  elseif x > y then
    return -10000
  elseif cache[y][x] ~= 0
  then
    return cache[y][x]
  end
  local result = 0
  local out0 = find0(len, tab, cache, x, y + 1)
  local out1 = find0(len, tab, cache, x + 1, y + 1)
  if out0 > out1
  then
    result = out0 + tab[y][x];
  else
    result = out1 + tab[y][x];
  end
  cache[y][x] = result;
  return result
end

function find( len, tab )
  local tab2 = {}
  for i = 0,len - 1 do
  local tab3 = {}
    for j = 0,i + 1 - 1 do
    tab3[j] = 0;
      end
      tab2[i] = tab3;
      end
      return find0(len, tab, tab2, 0, 0)
    end
    
    
    local len = 0
    len = readint()
    stdinsep()
    local tab = {}
    for i = 0,len - 1 do
    local tab2 = {}
      for j = 0,i + 1 - 1 do
      local tmp = 0
        tmp = readint()
        stdinsep()
        tab2[j] = tmp;
        end
        tab[i] = tab2;
        end
        io.write(string.format("%d\n", find(len, tab)))
        for k = 0,len - 1 do
        for l = 0,k do
        io.write(string.format("%d ", tab[k][l]))
          end
          io.write("\n")
          end
          