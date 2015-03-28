"""
TODO ajouter un record qui contient des chaines.
"""
def idstring( s ):
    return s

def printstring( s ):
    print("%s\n" % ( idstring(s) ), end='')

tab = [None] * 2
for i in range(0, 2):
  tab[i] = idstring("chaine de test")
for j in range(0, 1 + 1):
  printstring(idstring(tab[j]))

