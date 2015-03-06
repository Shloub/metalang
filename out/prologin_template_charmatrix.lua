
function readcharline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), ".") do
    tab[i] = string.byte(a)
    i = i + 1
  end
  return tab
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


local taille_x = tonumber(io.read('*l'))
local taille_y = tonumber(io.read('*l'))
local a = {}
for b = 0,taille_y - 1 do
  a[b] = readcharline();
end
local tableau = a
io.write(string.format("%d\n", programme_candidat(tableau, taille_x, taille_y)))
