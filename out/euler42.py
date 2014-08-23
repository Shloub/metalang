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

def is_triangular( n ):
    """
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   """
    d = n * 2;
    a = math.floor(math.sqrt(d));
    return a * (a + 1) == n * 2;

def score(  ):
    stdinsep()
    len = 0;
    len=readint()
    stdinsep()
    sum = 0;
    for i in range(1, 1 + len):
      c = '_';
      c=readchar()
      sum += (ord(c) - ord('A')) + 1
      """		print c print " " print sum print " " """
    if is_triangular(sum):
      return 1;
    else:
      return 0;

for i in range(1, 1 + 55):
  if is_triangular(i):
    print("%d " % ( i ), end='')
print("")
sum = 0;
n = 0;
n=readint()
for i in range(1, 1 + n):
  sum += score()
print("%d\n" % ( sum ), end='')

