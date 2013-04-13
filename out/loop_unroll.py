
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

j = 0;
j = 0;
print("%d" % j, end='');
print("%s" % "\n", end='');
j = 1;
print("%d" % j, end='');
print("%s" % "\n", end='');
j = 2;
print("%d" % j, end='');
print("%s" % "\n", end='');
j = 3;
print("%d" % j, end='');
print("%s" % "\n", end='');
j = 4;
print("%d" % j, end='');
print("%s" % "\n", end='');

