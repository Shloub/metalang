--[[
TODO ajouter un record qui contient des chaines.
--]]
function idstring( s )
  return s
end

function printstring( s )
  io.write(string.format("%s\n", idstring(s)))
end


local tab = {}
for i = 0,2 - 1 do
  tab[i] = idstring("chaine de test");
end
for j = 0,1 do
  printstring(idstring(tab[j]));
end
