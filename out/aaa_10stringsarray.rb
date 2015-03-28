require "scanf.rb"

=begin

TODO ajouter un record qui contient des chaines.

=end

def idstring( s )
    return (s)
end

def printstring( s )
    printf "%s\n", idstring(s)
end

tab = [*0..2 - 1].map { |i|
  next (idstring("chaine de test"))
  }
for j in (0 ..  1) do
  printstring(idstring(tab[j]))
end

