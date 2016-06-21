require "scanf.rb"

def idstring( s )
  return s
end

def printstring( s )
  printf "%s\n", idstring(s)
end

def print_toto( t )
  printf "%s = %d\n", t["s"], t["v"]
end
tab = [*0..2-1].map { |i|
  
  next idstring("chaine de test")
  }
for j in (0 ..  1) do
    printstring(idstring(tab[j]))
    end
    print_toto({"s" => "one", "v" => 1})
    
    