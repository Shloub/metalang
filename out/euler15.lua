

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
            