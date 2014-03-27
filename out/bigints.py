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

def max2( a, b ):
    if a > b:
      return a;
    return b;


def read_bigint(  ):
    len = 0;
    len=readint()
    stdinsep()
    sign = '_';
    sign=readchar()
    stdinsep()
    chiffres = [None] * len
    for d in range(0, len):
      c = '_';
      c=readchar()
      chiffres[d] = ord(c) - ord('0');
    for i in range(0, 1 + math.trunc((len - 1) / 2)):
      tmp = chiffres[i];
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    stdinsep()
    out_ = {"bigint_sign":sign == '+', "bigint_len":len, "bigint_chiffres":chiffres}
    return out_;

def print_bigint( a ):
    if not (a["bigint_sign"]):
      print("%c" % '-', end='')
    for i in range(0, a["bigint_len"]):
      e = a["bigint_chiffres"][a["bigint_len"] - 1 - i];
      print("%d" % e, end='')

def bigint_eq( a, b ):
    """ Renvoie vrai si a = b """
    if a["bigint_sign"] != b["bigint_sign"]:
      return False;
    elif a["bigint_len"] != b["bigint_len"]:
      return False;
    else:
      for i in range(0, a["bigint_len"]):
        if a["bigint_chiffres"][i] != b["bigint_chiffres"][i]:
          return False;
      return True;

def bigint_gt( a, b ):
    """ Renvoie vrai si a > b """
    if a["bigint_sign"] and not (b["bigint_sign"]):
      return True;
    elif not (a["bigint_sign"]) and b["bigint_sign"]:
      return False;
    else:
      if a["bigint_len"] > b["bigint_len"]:
        return a["bigint_sign"];
      elif a["bigint_len"] < b["bigint_len"]:
        return not (a["bigint_sign"]);
      else:
        for i in range(0, a["bigint_len"]):
          j = a["bigint_len"] - 1 - i;
          if a["bigint_chiffres"][j] > b["bigint_chiffres"][j]:
            return a["bigint_sign"];
          elif a["bigint_chiffres"][j] < b["bigint_chiffres"][j]:
            return a["bigint_sign"];
      return True;

def bigint_lt( a, b ):
    return not (bigint_gt(a, b));

def add_bigint_positif( a, b ):
    """ Une addition ou on en a rien a faire des signes """
    len = max2(a["bigint_len"], b["bigint_len"]) + 1;
    retenue = 0;
    chiffres = [None] * len
    for i in range(0, len):
      tmp = retenue;
      if i < a["bigint_len"]:
        tmp += a["bigint_chiffres"][i]
      if i < b["bigint_len"]:
        tmp += b["bigint_chiffres"][i]
      retenue = math.trunc(tmp / 10);
      chiffres[i] = mod(tmp, 10);
    if chiffres[len - 1] == 0:
      len -= 1
    out_ = {"bigint_sign":True, "bigint_len":len, "bigint_chiffres":chiffres}
    return out_;

def sub_bigint_positif( a, b ):
    """ Une soustraction ou on en a rien a faire des signes
Pré-requis : a > b
"""
    len = a["bigint_len"];
    retenue = 0;
    chiffres = [None] * len
    for i in range(0, len):
      tmp = retenue + a["bigint_chiffres"][i];
      if i < b["bigint_len"]:
        tmp -= b["bigint_chiffres"][i]
      if tmp < 0:
        tmp += 10
        retenue = -(1);
      else:
        retenue = 0;
      chiffres[i] = tmp;
    while (len > 0 and chiffres[len - 1] == 0):
      len -= 1
    out_ = {"bigint_sign":True, "bigint_len":len, "bigint_chiffres":chiffres}
    return out_;

def neg_bigint( a ):
    out_ = {"bigint_sign":not (a["bigint_sign"]), "bigint_len":a["bigint_len"], 
    "bigint_chiffres":a["bigint_chiffres"]}
    return out_;

def add_bigint( a, b ):
    if a["bigint_sign"] == b["bigint_sign"]:
      if a["bigint_sign"]:
        return add_bigint_positif(a, b);
      else:
        return neg_bigint(add_bigint_positif(a, b));
    elif a["bigint_sign"]:
      """ a positif, b negatif """
      if bigint_gt(a, neg_bigint(b)):
        return sub_bigint_positif(a, b);
      else:
        return neg_bigint(sub_bigint_positif(b, a));
    else:
      """ a negatif, b positif """
      if bigint_gt(neg_bigint(a), b):
        return neg_bigint(sub_bigint_positif(a, b));
      else:
        return sub_bigint_positif(b, a);

def sub_bigint( a, b ):
    return add_bigint(a, neg_bigint(b));

def mul_bigint_cp( a, b ):
    """ Cet algorithm est quadratique.
C'est le même que celui qu'on enseigne aux enfants en CP.
D'ou le nom de la fonction. """
    len = a["bigint_len"] + b["bigint_len"] + 1;
    chiffres = [None] * len
    for k in range(0, len):
      chiffres[k] = 0;
    for i in range(0, a["bigint_len"]):
      retenue = 0;
      for j in range(0, b["bigint_len"]):
        chiffres[i + j] = chiffres[i + j] + retenue + b["bigint_chiffres"][j] * a["bigint_chiffres"][i];
        retenue = math.trunc(chiffres[i + j] / 10);
        chiffres[i + j] = mod(chiffres[i + j], 10);
      chiffres[i + b["bigint_len"]] = chiffres[i + b["bigint_len"]] + retenue;
    chiffres[a["bigint_len"] + b["bigint_len"]] = math.trunc(chiffres[a["bigint_len"] + b["bigint_len"] - 1] / 10);
    chiffres[a["bigint_len"] + b["bigint_len"] - 1] = mod(chiffres[a["bigint_len"] + b["bigint_len"] - 1], 10);
    for l in range(0, 1 + 2):
      if chiffres[len - 1] == 0:
        len -= 1
    out_ = {"bigint_sign":a["bigint_sign"] == b["bigint_sign"], "bigint_len":len, 
    "bigint_chiffres":chiffres}
    return out_;

def bigint_premiers_chiffres( a, i ):
    out_ = {"bigint_sign":a["bigint_sign"], "bigint_len":i, "bigint_chiffres":a["bigint_chiffres"]}
    return out_;

def bigint_shift( a, i ):
    f = a["bigint_len"] + i;
    chiffres = [None] * f
    for k in range(0, f):
      if k >= i:
        chiffres[k] = a["bigint_chiffres"][k - i];
      else:
        chiffres[k] = 0;
    out_ = {"bigint_sign":a["bigint_sign"], "bigint_len":a["bigint_len"] + i, 
    "bigint_chiffres":chiffres}
    return out_;

def mul_bigint( aa, bb ):
    if aa["bigint_len"] < 3 or bb["bigint_len"] < 3:
      return mul_bigint_cp(aa, bb);
    """ Algorithme de Karatsuba """
    split = math.trunc(max2(aa["bigint_len"], bb["bigint_len"]) / 2);
    a = bigint_shift(aa, -(split));
    b = bigint_premiers_chiffres(aa, split);
    c = bigint_shift(bb, -(split));
    d = bigint_premiers_chiffres(bb, split);
    amoinsb = sub_bigint(a, b);
    cmoinsd = sub_bigint(c, d);
    ac = mul_bigint(a, c);
    bd = mul_bigint(b, d);
    amoinsbcmoinsd = mul_bigint(amoinsb, cmoinsd);
    acdec = bigint_shift(ac, 2 * split);
    return add_bigint(add_bigint(acdec, bd), bigint_shift(sub_bigint(add_bigint(ac, bd), amoinsbcmoinsd), split));
    """ ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd """

"""
Division,
Modulo
Exp
"""
a = read_bigint();
b = read_bigint();
print_bigint(a);
print( ">>1=", end='')
print_bigint(bigint_shift(a, -(1)));
print("")
print_bigint(a);
print( "*", end='')
print_bigint(b);
print( "=", end='')
print_bigint(mul_bigint(a, b));
print("")
print_bigint(a);
print( "*", end='')
print_bigint(b);
print( "=", end='')
print_bigint(mul_bigint_cp(a, b));
print("")
print_bigint(a);
print( "+", end='')
print_bigint(b);
print( "=", end='')
print_bigint(add_bigint(a, b));
print("")
print_bigint(b);
print( "-", end='')
print_bigint(a);
print( "=", end='')
print_bigint(sub_bigint(b, a));
print("")
print_bigint(a);
print( "-", end='')
print_bigint(b);
print( "=", end='')
print_bigint(sub_bigint(a, b));
print("")
print_bigint(a);
print( ">", end='')
print_bigint(b);
print( "=", end='')
g = bigint_gt(a, b);
if g:
  print( "True", end='')
else:
  print( "False", end='')
print("")

