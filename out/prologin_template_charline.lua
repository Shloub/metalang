
function readcharline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), ".") do
    tab[i] = string.byte(a)
    i = i + 1
  end
  return tab
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


local taille = tonumber(io.read('*l'))
local tableau = readcharline()
io.write(string.format("%d\n", programme_candidat(tableau, taille)))
