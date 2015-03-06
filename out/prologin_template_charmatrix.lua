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
function programme_candidat( tableau, taille_x, taille_y )
  local out0 = 0
  for i = 0,taille_y - 1 do
  for j = 0,taille_x - 1 do
  out0 = out0 + tableau[i][j] * (i + j * 2);
    io.write(string.format("%c", tableau[i][j]))
    end
    io.write("--\n")
    end
    return out0
    end
    
    
    local taille_x = readint()
    stdinsep()
    local taille_y = readint()
    stdinsep()
    local a = {}
    for b = 0,taille_y - 1 do
    local c = {}
      for d = 0,taille_x - 1 do
      c[d] = readchar()
        end
        stdinsep()
        a[b] = c;
        end
        local tableau = a
        io.write(string.format("%d\n", programme_candidat(tableau, taille_x, taille_y)))
        