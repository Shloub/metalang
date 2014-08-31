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
def mod(x, y):
  return x - y * math.trunc(x / y)

i = 1;
last = [None] * 5
for j in range(0, 5):
  c=readchar()
  d = ord(c) - ord('0');
  i *= d
  last[j] = d;
max_ = i;
index = 0;
nskipdiv = 0;
for k in range(1, 1 + 995):
  e=readchar()
  f = ord(e) - ord('0');
  if f == 0:
    i = 1;
    nskipdiv = 4;
  else:
    i *= f
    if nskipdiv < 0:
      i = math.trunc(i / last[index])
    nskipdiv -= 1
  last[index] = f;
  index = mod(index + 1, 5);
  max_ = max(max_, i);
print("%d\n" % ( max_ ), end='')

