import math
def mod(x, y):
    return x - y * math.trunc(x / y)



i = 0
i -= 1
print("%d\n" % i, end='')
i += 55
print("%d\n" % i, end='')
i *= 13
print("%d\n" % i, end='')
i = math.trunc(i / 2)
print("%d\n" % i, end='')
i += 1
print("%d\n" % i, end='')
i = math.trunc(i / 3)
print("%d\n" % i, end='')
i -= 1
print("%d\n" % i, end='')
#
#http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
#

print("%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n" % (math.trunc(117 / 17), math.trunc(117 / -17), math.trunc(-117 / 17), math.trunc(-117 / -17), mod(117, 17), mod(117, -17), mod(-117, 17), mod(-117, -17)), end='')

