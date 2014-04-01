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

def cons( list, i ):
    out_ = {
      "head":i,
      "tail":list};
    return out_;

def rev2( empty, acc, torev ):
    if torev == empty:
      return acc;
    else:
      acc2 = {
        "head":torev["head"],
        "tail":acc};
      return rev2(empty, acc, torev["tail"]);

def rev( empty, torev ):
    return rev2(empty, empty, torev);

def test( empty ):
    list = empty;
    i = -(1);
    while (i != 0):
      i=readint()
      if i != 0:
        list = cons(list, i);



