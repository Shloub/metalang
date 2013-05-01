
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


def montagnes_( tab, len ):
    max_ = 1;
    j = 1;
    i = len - 2;
    while (i >= 0):
      x = tab[i];
      while (j >= 0 and x > tab[len - j]):
        j = j - 1;
      j = j + 1;
      tab[len - j] = x;
      if j > max_:
        max_ = j;
      i = i - 1;
    return max_;

len = 0;
len=readint();
stdinsep();
tab = [None] * len;
for i in range(0, len):
  x = 0;
  x=readint();
  stdinsep();
  tab[i] = x;
m = montagnes_(tab, len);
print("%d" % m, end='');

