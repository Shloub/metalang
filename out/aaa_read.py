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
def readchar():
  out = readchar_()
  skipchar()
  return out
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


"""
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
"""
len = 0;
len=readint()
stdinsep()
print("%d=len\n" % ( len ), end='')
tab = [None] * len
for i in range(0, len):
  tmpi1 = 0;
  tmpi1=readint()
  stdinsep()
  print("%d=>%d " % ( i, tmpi1 ), end='')
  tab[i] = tmpi1;
print("")
tab2 = [None] * len
for i_ in range(0, len):
  tmpi2 = 0;
  tmpi2=readint()
  stdinsep()
  print("%d==>%d " % ( i_, tmpi2 ), end='')
  tab2[i_] = tmpi2;
strlen = 0;
strlen=readint()
stdinsep()
print("%d=strlen\n" % ( strlen ), end='')
tab4 = [None] * strlen
for toto in range(0, strlen):
  tmpc = '_';
  tmpc=readchar()
  c = ord(tmpc);
  print("%c:%d " % ( tmpc, c ), end='')
  if tmpc != ' ':
    c = ((c - ord('a')) + 13) % 26 + ord('a');
  tab4[toto] = c;
for j in range(0, strlen):
  a = tab4[j];
  print("%c" % a, end='')

