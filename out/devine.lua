

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



function devine0( nombre, tab, len )
  local min0 = tab[0]
  local max0 = tab[1]
  for i = 2,len - 1 do
  if tab[i] > max0 or tab[i] < min0
    then
      return false
    end
    if tab[i] < nombre
    then
      min0 = tab[i];
    end
    if tab[i] > nombre
    then
      max0 = tab[i];
    end
    if tab[i] == nombre and len ~= i + 1
    then
      return false
    end
    end
    return true
  end
  
  
  local nombre = readint()
  stdinsep()
  local len = readint()
  stdinsep()
  local tab = {}
  for i = 0,len - 1 do
  local tmp = readint()
    stdinsep()
    tab[i] = tmp;
    end
    local a = devine0(nombre, tab, len)
    if a
    then
      io.write("True")
    else
      io.write("False")
    end
    