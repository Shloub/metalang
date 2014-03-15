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

def mktoto( v1 ):
    t_ = {"foo":v1, "bar":0, "blah":0}
    return t_;

def result( t_, len ):
    out_ = 0;
    for j in range(0, len):
      t_[j]["blah"] = t_[j]["blah"] + 1;
      out_ = out_ + t_[j]["foo"] + t_[j]["blah"] * t_[j]["bar"] + t_[j]["bar"] * t_[j]["foo"];
    return out_;

a = 4;
t_ = [None] * a
for i in range(0, a):
  t_[i] = mktoto(i);
t_[0]["bar"]=readint()
stdinsep()
t_[1]["blah"]=readint()
b = result(t_, 4);
print("%d" % b, end='')
c = t_[2]["blah"];
print("%d" % c, end='')

