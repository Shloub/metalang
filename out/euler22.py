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
def readchar():
  out = readchar_()
  skipchar()
  return out
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

def score(  ):
    stdinsep()
    len=readint()
    stdinsep()
    sum = 0
    for i in range(1, 1 + len):
      c=readchar()
      sum += (ord(c) - ord('A')) + 1
      """		print c print " " print sum print " " """
    return sum

sum = 0
n=readint()
for i in range(1, 1 + n):
  sum += i * score()
print("%d\n" % ( sum ), end='')

