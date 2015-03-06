

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


--[[
  Ce test a été généré par Metalang.
--]]
function result( len, tab )
  local tab2 = {}
  for i = 0,len - 1 do
  tab2[i] = false;
    end
    for i1 = 0,len - 1 do
    io.write(string.format("%d ", tab[i1]))
      tab2[tab[i1]] = true;
      end
      io.write("\n")
      for i2 = 0,len - 1 do
      if not(tab2[i2])
        then
          return i2
        end
        end
        return -1
      end
      
      
      local len = readint()
      stdinsep()
      io.write(string.format("%d\n", len))
      local tab = {}
      for a = 0,len - 1 do
      tab[a] = readint()
        stdinsep()
        end
        io.write(string.format("%d\n", result(len, tab)))
        