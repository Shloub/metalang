import math
def mod(x, y):
  return x - y * math.trunc(x / y)
i = 0;
i -= 1
print("%d\n" % ( i ), end='')
i += 55
print("%d\n" % ( i ), end='')
i *= 13
print("%d\n" % ( i ), end='')
i = math.trunc(i / 2)
print("%d\n" % ( i ), end='')
i += 1
print("%d\n" % ( i ), end='')
i = math.trunc(i / 3)
print("%d\n" % ( i ), end='')
i -= 1
print("%d\n" % ( i ), end='')
"""
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
"""
a = math.trunc(117 / 17);
print("%d\n" % ( a ), end='')
b = math.trunc(117 / -(17));
print("%d\n" % ( b ), end='')
c = math.trunc(-(117) / 17);
print("%d\n" % ( c ), end='')
d = math.trunc(-(117) / -(17));
print("%d\n" % ( d ), end='')
e = mod(117, 17);
print("%d\n" % ( e ), end='')
f = mod(117, -(17));
print("%d\n" % ( f ), end='')
g = mod(-(117), 17);
print("%d\n" % ( g ), end='')
h = mod(-(117), -(17));
print("%d\n" % ( h ), end='')

