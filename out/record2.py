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

def mktoto( v1 ):
    t_ = {"foo":v1, "bar":0, "blah":0}
    return t_;

def result( t_ ):
    t_["blah"] += 1
    return t_["foo"] + t_["blah"] * t_["bar"] + t_["bar"] * t_["foo"];

t_ = mktoto(4);
t_["bar"]=readint()
stdinsep()
t_["blah"]=readint()
a = result(t_);
print("%d" % a, end='')
b = t_["blah"];
print("%d" % b, end='')

