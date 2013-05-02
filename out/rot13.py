
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



"""
Ce test effectue un rot13 sur une chaine lue en entrée
"""
strlen = 0;
strlen=readint();
stdinsep();
tab4 = [None] * strlen;
for toto in range(0, strlen):
  tmpc = '_';
  tmpc=readchar();
  c = ord(tmpc);
  if tmpc != ' ':
    c = ((c - ord('a')) + 13) % 26 + ord('a');
  tab4[toto] = c;
for j in range(0, strlen):
  l = tab4[j];
  print("%c" % l, end='');

