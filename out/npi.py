
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


def is_number( c ):
    return ord(c) <= ord('9') and ord(c) >= ord('0');

"""
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
"""
def npi_( str, len ):
    stack = [None] * len;
    for i in range(0, len):
      stack[i] = 0;
    ptrStack = 0;
    ptrStr = 0;
    while (ptrStr < len):
      if str[ptrStr] == ' ':
        ptrStr = ptrStr + 1;
      elif is_number(str[ptrStr]):
        num = 0;
        while (str[ptrStr] != ' '):
          num = num * 10 + ord(str[ptrStr]) - ord('0');
          ptrStr = ptrStr + 1;
        stack[ptrStack] = num;
        ptrStack = ptrStack + 1;
      elif str[ptrStr] == '+':
        stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
        ptrStack = ptrStack - 1;
        ptrStr = ptrStr + 1;
    return stack[0];

len = 0;
len=readint();
stdinsep();
tab = [None] * len;
for i in range(0, len):
  tmp = '\000';
  tmp=readchar();
  tab[i] = tmp;
result = npi_(tab, len);
print("%d" % result, end='');

