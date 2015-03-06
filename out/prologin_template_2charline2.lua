

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



function programme_candidat( tableau1, taille1, tableau2, taille2 )
  local out0 = 0
  for i = 0,taille1 - 1 do
  out0 = out0 + tableau1[i] * i;
    io.write(string.format("%c", tableau1[i]))
    end
    io.write("--\n")
    for j = 0,taille2 - 1 do
    out0 = out0 + tableau2[j] * j * 100;
      io.write(string.format("%c", tableau2[j]))
      end
      io.write("--\n")
      return out0
    end
    
    
    local taille1 = readint()
    stdinsep()
    local taille2 = readint()
    stdinsep()
    local tableau1 = {}
    for a = 0,taille1 - 1 do
    tableau1[a] = readchar()
      end
      stdinsep()
      local tableau2 = {}
      for b = 0,taille2 - 1 do
      tableau2[b] = readchar()
        end
        stdinsep()
        io.write(string.format("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2)))
        