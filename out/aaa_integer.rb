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
i = (i.to_f / 2).to_i
printf "%d\n", i
i += 1
printf "%d\n", i
i = (i.to_f / 3).to_i
printf "%d\n", i
i -= 1
printf "%d\n", i
#
#http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
#

printf "%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n", (117.to_f / 17).to_i, (117.to_f / -17).to_i, (-117.to_f / 17).to_i, (-117.to_f / -17).to_i, mod(117, 17), mod(117, -17), mod(-117, 17), mod(-117, -17)
