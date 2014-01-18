
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


"""
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
"""

def mktoto( v1 ):
    t = {"foo":v1, "bar":v1, "blah":v1};
    return t;

def result( t_, t2_ ):
    t = t_;
    t2 = t2_;
    t3 = {"foo":0, "bar":0, "blah":0};
    t3 = t2;
    t = t2;
    t2 = t3;
    t["blah"] += 1;
    len = 1;
    cache0 = [None] * len;
    for i in range(0, len):
      cache0[i] = -(i);
    cache1 = [None] * len;
    for j in range(0, len):
      cache1[j] = j;
    cache2 = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t["foo"] + t["blah"] * t["bar"] + t["bar"] * t["foo"];

t = mktoto(4);
t2 = mktoto(5);
t["bar"]=readint();
stdinsep();
t["blah"]=readint();
stdinsep();
t2["bar"]=readint();
stdinsep();
t["blah"]=readint();
w = result(t, t2);
print("%d" % w, end='');
x = t["blah"];
print("%d" % x, end='');

