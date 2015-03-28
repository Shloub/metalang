
def idstring( s ):
    return s

def printstring( s ):
    print("%s\n" % ( idstring(s) ), end='')

def print_toto( t ):
    print("%s = %d\n" % ( t["s"], t["v"] ), end='')

tab = [None] * 2
for i in range(0, 2):
  tab[i] = idstring("chaine de test")
for j in range(0, 1 + 1):
  printstring(idstring(tab[j]))
print_toto({
  "s":"one",
  "v":1})

