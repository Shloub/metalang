
import sys

char=None
def readchar_():
  global char;
  if char == None:
    char = sys.stdin.read(1);
  return char;

def skipchar():
  global char;
  char = None;
  return;

def stdinsep():
  while True:
    c = readchar_();
    if c == '\n' or c == '\t' or c == '\r' or c == ' ':
      skipchar();
    else:
      return;

def readint():
  c = readchar_();
  if c == '-':
    sign = -1;
    skipchar();
  else:
    sign = 1;
  out = 0;
  while True:
    c = readchar_();
    if c <= '9' and c >= '0' :
      out = out * 10 + int(c);
      skipchar();
    else:
      return out * sign;


def go( tab, a, b ):
    m = a + b // 2;
    if a == m:
      if tab[a] == m:
        return b;
      else:
        return a;
    i = a;
    j = b;
    while (i < j):
      e = tab[i];
      if e < m:
        i += 1;
      else:
        j -= 1;
        tab[i] = tab[j];
        tab[j] = e;
    if i < m:
      return go(tab, a, m);
    else:
      return go(tab, m, b);

def plus_petit_( tab, len ):
    return go(tab, 0, len);

len = 0;
len=readint();
stdinsep();
tab = [None] * len;
for i in range(0, len):
  tmp = 0;
  tmp=readint();
  stdinsep();
  tab[i] = tmp;
c = plus_petit_(tab, len);
print("%d" % c, end='');

