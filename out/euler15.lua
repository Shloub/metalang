
local n = 10
--[[ normalement on doit mettre 20 mais là on se tape un overflow --]]
n = n + 1;
local tab = {}
for i = 0,n - 1 do
  local tab2 = {}
  for j = 0,n - 1 do
    tab2[j] = 0;
  end
  tab[i] = tab2;
end
for l = 0,n - 1 do
  tab[n - 1][l] = 1;
  tab[l][n - 1] = 1;
end
for o = 2,n do
  local r = n - o
  for p = 2,n do
    local q = n - p
    tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
  end
end
for m = 0,n - 1 do
  for k = 0,n - 1 do
    io.write(string.format("%d ", tab[m][k]))
  end
  io.write("\n")
end
io.write(string.format("%d\n", tab[0][0]))
