

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
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
--]]

local len = readint()
stdinsep()
io.write(string.format("%d=len\n", len))
local tab = {}
for a = 0,len - 1 do
tab[a] = readint()
  stdinsep()
  end
  for i = 0,len - 1 do
  io.write(string.format("%d=>%d ", i, tab[i]))
    end
    io.write("\n")
    local tab2 = {}
    for b = 0,len - 1 do
    tab2[b] = readint()
      stdinsep()
      end
      for i_ = 0,len - 1 do
      io.write(string.format("%d==>%d ", i_, tab2[i_]))
        end
        local strlen = readint()
        stdinsep()
        io.write(string.format("%d=strlen\n", strlen))
        local tab4 = {}
        for d = 0,strlen - 1 do
        tab4[d] = readchar()
          end
          stdinsep()
          for i3 = 0,strlen - 1 do
          local tmpc = tab4[i3]
            local c = tmpc
            io.write(string.format("%c:%d ", tmpc, c))
            if tmpc ~= 32
            then
              c = math.mod((c - 97) + 13, 26) + 97;
            end
            tab4[i3] = c;
            end
            for j = 0,strlen - 1 do
            io.write(string.format("%c", tab4[j]))
              end
              