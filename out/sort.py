
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


def sort_( tab, len ):
    for i in range(0, len):
      for j in range(i + 1, len):
        if tab[i] > tab[j]:
          tmp = tab[i];
          tab[i] = tab[j];
          tab[j] = tmp;

len = 2;
len=readint();
stdinsep();
tab = [None] * len;
for i in range(0, len):
  tmp = 0;
  tmp=readint();
  stdinsep();
  tab[i] = tmp;
sort_(tab, len);
for i in range(0, len):
  m = tab[i];
  print("%d" % m, end='');

