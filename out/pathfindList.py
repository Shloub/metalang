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

def pathfind_aux( cache, tab, len, pos ):
    if pos >= len - 1:
      return 0;
    elif cache[pos] != -(1):
      return cache[pos];
    else:
      cache[pos] = len * 2;
      posval = pathfind_aux(cache, tab, len, tab[pos]);
      oneval = pathfind_aux(cache, tab, len, pos + 1);
      out_ = 0;
      if posval < oneval:
        out_ = 1 + posval;
      else:
        out_ = 1 + oneval;
      cache[pos] = out_;
      return out_;

def pathfind( tab, len ):
    cache = [None] * len
    for i in range(0, len):
      cache[i] = -(1);
    return pathfind_aux(cache, tab, len, 0);

len = 0;
len=readint()
stdinsep()
tab = [None] * len
for i in range(0, len):
  tmp = 0;
  tmp=readint()
  stdinsep()
  tab[i] = tmp;
result = pathfind(tab, len);
print("%d" % result, end='')

