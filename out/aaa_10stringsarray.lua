
function idstring( s )
  return s
end

function printstring( s )
  io.write(string.format("%s\n", idstring(s)))
end

function print_toto( t )
  io.write(string.format("%s = %d\n", t.s, t.v))
end


local tab = {}
for i = 0,2 - 1 do
  tab[i] = idstring("chaine de test");
end
for j = 0,1 do
  printstring(idstring(tab[j]));
end
print_toto({s="one",
            v=1});
