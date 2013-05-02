
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


def sumdiv( n ):
    """ On désire renvoyer la somme des diviseurs """
    out_ = 0;
    """ On déclare un entier qui contiendra la somme """
    for i in range(1, 1 + n):
      """ La boucle : i est le diviseur potentiel"""
      if (n % i) == 0:
        """ Si i divise """
        out_ += i;
        """ On incrémente """
      else:
        """ nop """
    return out_;
    """On renvoie out"""

""" Programme principal """
n = 0;
n=readint();
""" Lecture de l'entier """
k = sumdiv(n);
print("%d" % k, end='');

