

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



function programme_candidat( tableau, taille )
  local out0 = 0
  for i = 0,taille - 1 do
  out0 = out0 + tableau[i] * i;
    io.write(string.format("%c", tableau[i]))
    end
    io.write("--\n")
    return out0
  end
  
  
  local taille = readint()
  stdinsep()
  local tableau = {}
  for a = 0,taille - 1 do
  tableau[a] = readchar()
    end
    stdinsep()
    io.write(string.format("%d\n", programme_candidat(tableau, taille)))
    