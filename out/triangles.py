
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

""" Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
"""
def find0( len, tab, cache, x, y ):
    """
	Cette fonction est récursive
	"""
    if y == len - 1:
      return tab[y][x];
    elif x > y:
      return 100000;
    elif cache[y][x] != 0:
      return cache[y][x];
    result = 0;
    out0 = find0(len, tab, cache, x, y + 1);
    out1 = find0(len, tab, cache, x + 1, y + 1);
    if out0 < out1:
      result = out0 + tab[y][x];
    else:
      result = out1 + tab[y][x];
    cache[y][y] = result;
    return result;

def find( len, tab ):
    tab2 = [None] * len;
    for i in range(0, len):
      bq = i + 1;
      tab3 = [None] * bq;
      for j in range(0, bq):
        tab3[j] = 0;
      tab2[i] = tab3;
    return find0(len, tab, tab2, 0, 0);

len = 0;
len=readint();
stdinsep();
tab = [None] * len;
for i in range(0, len):
  br = i + 1;
  tab2 = [None] * br;
  for j in range(0, br):
    tmp = 0;
    tmp=readint();
    stdinsep();
    tab2[j] = tmp;
  tab[i] = tab2;
bs = find(len, tab);
print("%d" % bs, end='');
for i in range(0, len):
  for j in range(0, 1 + i):
    bt = tab[i][j];
    print("%d" % bt, end='');
  print("%s" % "\n", end='');

