

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



local len = readint()
stdinsep()
io.write(string.format("%d=len\n", len))
local tab1 = {}
for a = 0,len - 1 do
tab1[a] = readint()
  stdinsep()
  end
  for i = 0,len - 1 do
  io.write(string.format("%d=>%d\n", i, tab1[i]))
    end
    len = readint()
    stdinsep()
    local tab2 = {}
    for b = 0,len - 1 - 1 do
    local c = {}
      for d = 0,len - 1 do
      c[d] = readint()
        stdinsep()
        end
        tab2[b] = c;
        end
        for i = 0,len - 2 do
        for j = 0,len - 1 do
        io.write(string.format("%d ", tab2[i][j]))
          end
          io.write("\n")
          end
          