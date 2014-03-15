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

def devine_( nombre, tab, len ):
    min_ = tab[0];
    max_ = tab[1];
    for i in range(2, len):
      if tab[i] > max_ or tab[i] < min_:
        return False;
      if tab[i] < nombre:
        min_ = tab[i];
      if tab[i] > nombre:
        max_ = tab[i];
      if tab[i] == nombre and len != i + 1:
        return False;
    return True;

nombre = 0;
nombre=readint()
stdinsep()
len = 0;
len=readint()
stdinsep()
tab = [None] * len
for i in range(0, len):
  tmp = 0;
  tmp=readint()
  stdinsep()
  tab[i] = tmp;
a = devine_(nombre, tab, len);
if a:
  print( "True", end='')
else:
  print( "False", end='')

