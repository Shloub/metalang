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
def mod(x, y):
  return x - y * math.trunc(x / y)

def position_alphabet( c ):
    i = ord(c);
    if i <= ord('Z') and i >= ord('A'):
      return i - ord('A');
    elif i <= ord('z') and i >= ord('a'):
      return i - ord('a');
    else:
      return -(1);

def of_position_alphabet( c ):
    return c + ord('a');

def crypte( taille_cle, cle, taille, message ):
    for i in range(0, taille):
      lettre = position_alphabet(message[i]);
      if lettre != -(1):
        addon = position_alphabet(cle[mod(i, taille_cle)]);
        new_ = mod(addon + lettre, 26);
        message[i] = of_position_alphabet(new_);

taille_cle=readint()
stdinsep()
cle = [None] * taille_cle
for index in range(0, taille_cle):
  out_=readchar()
  cle[index] = out_;
stdinsep()
taille=readint()
stdinsep()
message = [None] * taille
for index2 in range(0, taille):
  out2=readchar()
  message[index2] = out2;
crypte(taille_cle, cle, taille, message);
for i in range(0, taille):
  print("%c" % message[i], end='')
print("")

