
require "scanf.rb"

def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

i = 0
i -= 1
printf "%d\n", i
i += 55
printf "%d\n", i
i *= 13
printf "%d\n", i
i /= 2
printf "%d\n", i
i += 1
printf "%d\n", i
i /= 3
printf "%d\n", i
i -= 1
printf "%d\n", i

=begin

http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo

=end

a = (117.to_f / 17).to_i
printf "%d\n", a
b = (117.to_f / -17).to_i
printf "%d\n", b
c = (-117.to_f / 17).to_i
printf "%d\n", c
d = (-117.to_f / -17).to_i
printf "%d\n", d
e = mod(117, 17)
printf "%d\n", e
f = mod(117, -17)
printf "%d\n", f
g = mod(-117, 17)
printf "%d\n", g
h = mod(-117, -17)
printf "%d\n", h

