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

def summax( lst, len ):
    current = 0;
    max0 = 0;
    for i in range(0, len):
      current += lst[i]
      if current < 0:
        current = 0;
      if max0 < current:
        max0 = current;
    return max0;

len = 0;
len=readint()
stdinsep()
tab = [None] * len
for i in range(0, len):
  tmp = 0;
  tmp=readint()
  stdinsep()
  tab[i] = tmp;
result = summax(tab, len);
print("%d" % result, end='')

