import math
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
def mod(x, y):
  return x - y * math.trunc(x / y)
"""
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
"""

def mktoto( v1 ):
    t__ = {"foo":v1, "bar":v1, "blah":v1}
    return t__;

def result( t_, t2_ ):
    t__ = t_;
    t2 = t2_;
    t3 = {"foo":0, "bar":0, "blah":0}
    t3 = t2;
    t__ = t2;
    t2 = t3;
    t__["blah"] += 1
    len = 1;
    cache0 = [None] * len
    for i in range(0, len):
      cache0[i] = -(i);
    cache1 = [None] * len
    for j in range(0, len):
      cache1[j] = j;
    cache2 = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t__["foo"] + t__["blah"] * t__["bar"] + t__["bar"] * t__["foo"];

t__ = mktoto(4);
t2 = mktoto(5);
t__["bar"]=readint()
stdinsep()
t__["blah"]=readint()
stdinsep()
t2["bar"]=readint()
stdinsep()
t__["blah"]=readint()
a = result(t__, t2);
print("%d" % a, end='')
b = t__["blah"];
print("%d" % b, end='')

