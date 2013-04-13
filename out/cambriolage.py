
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

def readchar():
  out = readchar_();
  skipchar();
  return out;

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

def max2( a, b ):
    if a > b:
      return a;
    return b;

def nbPassePartout( n, passepartout, m, serrures ):
    max_ancient = 0;
    max_recent = 0;
    for i in range(0, m):
      if (serrures[i][0] == -(1)) and (serrures[i][1] > max_ancient):
        max_ancient = serrures[i][1];
      if (serrures[i][0] == 1) and (serrures[i][1] > max_recent):
        max_recent = serrures[i][1];
    max_ancient_pp = 0;
    max_recent_pp = 0;
    for i in range(0, n):
      pp = passepartout[i];
      if (pp[0] >= max_ancient) and (pp[1] >= max_recent):
        return 1;
      max_ancient_pp = max2(max_ancient_pp, pp[0]);
      max_recent_pp = max2(max_recent_pp, pp[1]);
    if (max_ancient_pp >= max_ancient) and (max_recent_pp >= max_recent):
      return 2;
    else:
      return 0;

n = 0;
n=readint();
stdinsep();
passepartout = [None] * n;
for i in range(0, n):
  bj = 2;
  out0 = [None] * bj;
  for j in range(0, bj):
    out_ = 0;
    out_=readint();
    stdinsep();
    out0[j] = out_;
  passepartout[i] = out0;
m = 0;
m=readint();
stdinsep();
serrures = [None] * m;
for i in range(0, m):
  bk = 2;
  out0 = [None] * bk;
  for j in range(0, bk):
    out_ = 0;
    out_=readint();
    stdinsep();
    out0[j] = out_;
  serrures[i] = out0;
bl = nbPassePartout(n, passepartout, m, serrures);
print("%d" % bl, end='');

