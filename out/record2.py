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
    t = {
      "foo":v1,
      "bar":0,
      "blah":0}
    return t

def result( t ):
    t["blah"] += 1
    return t["foo"] + t["blah"] * t["bar"] + t["bar"] * t["foo"]

t = mktoto(4)
t["bar"]=readint()
stdinsep()
t["blah"]=readint()
print("%d" % result(t), end='')

