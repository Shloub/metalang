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

def min2( a, b ):
    if a < b:
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
    return {
      "bigint_sign":sign == '+',
      "bigint_len":len,
      "bigint_chiffres":chiffres};

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
            return not (a["bigint_sign"]);
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
    while (len > 0 and chiffres[len - 1] == 0):
      len -= 1
    return {
      "bigint_sign":True,
      "bigint_len":len,
      "bigint_chiffres":chiffres};

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
    return {
      "bigint_sign":True,
      "bigint_len":len,
      "bigint_chiffres":chiffres};

def neg_bigint( a ):
    return {
      "bigint_sign":not (a["bigint_sign"]),
      "bigint_len":a["bigint_len"],
      "bigint_chiffres":a["bigint_chiffres"]};

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
      if len != 0 and chiffres[len - 1] == 0:
        len -= 1
    return {
      "bigint_sign":a["bigint_sign"] == b["bigint_sign"],
      "bigint_len":len,
      "bigint_chiffres":chiffres};

def bigint_premiers_chiffres( a, i ):
    len = min2(i, a["bigint_len"]);
    while (len != 0 and a["bigint_chiffres"][len - 1] == 0):
      len -= 1
    return {
      "bigint_sign":a["bigint_sign"],
      "bigint_len":len,
      "bigint_chiffres":a["bigint_chiffres"]};

def bigint_shift( a, i ):
    f = a["bigint_len"] + i;
    chiffres = [None] * f
    for k in range(0, f):
      if k >= i:
        chiffres[k] = a["bigint_chiffres"][k - i];
      else:
        chiffres[k] = 0;
    return {
      "bigint_sign":a["bigint_sign"],
      "bigint_len":a["bigint_len"] + i,
      "bigint_chiffres":chiffres};

def mul_bigint( aa, bb ):
    if aa["bigint_len"] == 0:
      return aa;
    elif bb["bigint_len"] == 0:
      return bb;
    elif aa["bigint_len"] < 3 or bb["bigint_len"] < 3:
      return mul_bigint_cp(aa, bb);
    """ Algorithme de Karatsuba """
    split = math.trunc(min2(aa["bigint_len"], bb["bigint_len"]) / 2);
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
"""
def log10( a ):
    out_ = 1;
    while (a >= 10):
      a = math.trunc(a / 10)
      out_ += 1
    return out_;

def bigint_of_int( i ):
    size = log10(i);
    if i == 0:
      size = 0;
    t = [None] * size
    for j in range(0, size):
      t[j] = 0;
    for k in range(0, size):
      t[k] = mod(i, 10);
      i = math.trunc(i / 10)
    return {
      "bigint_sign":True,
      "bigint_len":size,
      "bigint_chiffres":t};

def fact_bigint( a ):
    one = bigint_of_int(1);
    out_ = one;
    while (not (bigint_eq(a, one))):
      out_ = mul_bigint(a, out_);
      a = sub_bigint(a, one);
    return out_;

def sum_chiffres_bigint( a ):
    out_ = 0;
    for i in range(0, a["bigint_len"]):
      out_ += a["bigint_chiffres"][i]
    return out_;

""" http://projecteuler.net/problem=20 """
def euler20(  ):
    a = bigint_of_int(100);
    a = fact_bigint(a);
    return sum_chiffres_bigint(a);

def bigint_exp( a, b ):
    if b == 1:
      return a;
    elif (mod(b, 2)) == 0:
      return bigint_exp(mul_bigint(a, a), math.trunc(b / 2));
    else:
      return mul_bigint(a, bigint_exp(a, b - 1));

def bigint_exp_10chiffres( a, b ):
    a = bigint_premiers_chiffres(a, 10);
    if b == 1:
      return a;
    elif (mod(b, 2)) == 0:
      return bigint_exp_10chiffres(mul_bigint(a, a), math.trunc(b / 2));
    else:
      return mul_bigint(a, bigint_exp_10chiffres(a, b - 1));

def euler48(  ):
    sum = bigint_of_int(0);
    for i in range(1, 1 + 1000):
      ib = bigint_of_int(i);
      ibeib = bigint_exp_10chiffres(ib, i);
      sum = add_bigint(sum, ibeib);
      sum = bigint_premiers_chiffres(sum, 10);
    print( "euler 48 = ", end='')
    print_bigint(sum);
    print("")

def euler16(  ):
    a = bigint_of_int(2);
    a = bigint_exp(a, 1000);
    return sum_chiffres_bigint(a);

def euler25(  ):
    i = 2;
    a = bigint_of_int(1);
    b = bigint_of_int(1);
    while (b["bigint_len"] < 1000):
      c = add_bigint(a, b);
      a = b;
      b = c;
      i += 1
    return i;

print( "euler25 = ", end='')
g = euler25();
print("%d\neuler16 = " % ( g ), end='')
h = euler16();
print("%d\n" % ( h ), end='')
euler48();
print( "euler20 = ", end='')
m = euler20();
print("%d\n" % ( m ), end='')
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
n = bigint_gt(a, b);
if n:
  print( "True", end='')
else:
  print( "False", end='')
print("")

