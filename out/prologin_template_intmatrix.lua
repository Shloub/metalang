

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



function programme_candidat( tableau, x, y )
  local out0 = 0
  for i = 0,y - 1 do
  for j = 0,x - 1 do
  out0 = out0 + tableau[i][j] * (i * 2 + j);
    end
    end
    return out0
    end
    
    
    local taille_x = readint()
    stdinsep()
    local taille_y = readint()
    stdinsep()
    local tableau = {}
    for a = 0,taille_y - 1 do
    local b = {}
      for c = 0,taille_x - 1 do
      b[c] = readint()
        stdinsep()
        end
        tableau[a] = b;
        end
        io.write(string.format("%d\n", programme_candidat(tableau, taille_x, taille_y)))
        