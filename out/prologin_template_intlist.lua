
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), "-?%d+") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end
function programme_candidat( tableau, taille )
  local out0 = 0
  for i = 0,taille - 1 do
    out0 = out0 + tableau[i];
  end
  return out0
end


local taille = tonumber(io.read('*l'))
local tableau = readintline()
io.write(string.format("%d\n", programme_candidat(tableau, taille)))
