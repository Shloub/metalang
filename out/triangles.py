import sys
char=None
def readchar_():
  global char
  if char == None:
    char = sys.stdin.read(1)
  return char

def skipchar():
  global char
  char = None
  return
def stdinsep():
  while True:
    c = readchar_()
    if c == '\n' or c == '\t' or c == '\r' or c == ' ':
      skipchar()
    else:
      return
def readint():
  c = readchar_()
  if c == '-':
    sign = -1
    skipchar()
  else:
    sign = 1
  out = 0
  while True:
    c = readchar_()
    if c <= '9' and c >= '0' :
      out = out * 10 + int(c)
      skipchar()
    else:
      return out * sign
""" Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
"""
def find0( len, tab, cache, x, y ):
    """
	Cette fonction est récursive
	"""
    if y == len - 1:
      return tab[y][x]
    elif x > y:
      return -10000
    elif cache[y][x] != 0:
      return cache[y][x]
    result = 0
    out0 = find0(len, tab, cache, x, y + 1)
    out1 = find0(len, tab, cache, x + 1, y + 1)
    if out0 > out1:
      result = out0 + tab[y][x]
    else:
      result = out1 + tab[y][x]
    cache[y][x] = result
    return result

def find( len, tab ):
    tab2 = [None] * len
    for i in range(0, len):
      tab3 = [0] * (i + 1)
      tab2[i] = tab3
    return find0(len, tab, tab2, 0, 0)

len = 0
len=readint()
stdinsep()
tab = [None] * len
for i in range(0, len):
  tab2 = [None] * (i + 1)
  for j in range(0, i + 1):
    tmp = 0
    tmp=readint()
    stdinsep()
    tab2[j] = tmp
  tab[i] = tab2
print("%d\n" % ( find(len, tab) ), end='')
for k in range(0, len):
  for l in range(0, 1 + k):
    print("%d " % ( tab[k][l] ), end='')
  print("")

