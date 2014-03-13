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

def max2( a, b ):
    if a > b:
      return a;
    return b;


def read_bigint_nat(  ):
    len = 0;
    len=readint()
    stdinsep()
    chiffres = [None] * len
    for d in range(0, len):
      c = '_';
      c=readchar()
      chiffres[d] = ord(c) - ord('0');
    for i in range(0, 1 + len // 2):
      tmp = chiffres[i];
      chiffres[i] = chiffres[len - 1 - i];
      chiffres[len - 1 - i] = tmp;
    stdinsep()
    out_ = {"bigint_nat_len":len, "bigint_nat_chiffres":chiffres}
    return out_;

def print_bigint_nat( a ):
    for i in range(0, a["bigint_nat_len"]):
      e = a["bigint_nat_chiffres"][a["bigint_nat_len"] - 1 - i];
      print("%d " % ( e ), end='')
    print( "|", end='')

def add_bigint_nat( a, b ):
    len = max2(a["bigint_nat_len"], b["bigint_nat_len"]) + 1;
    retenue = 0;
    chiffres = [None] * len
    for i in range(0, len):
      tmp = retenue;
      if i < a["bigint_nat_len"]:
        tmp += a["bigint_nat_chiffres"][i]
      if i < b["bigint_nat_len"]:
        tmp += b["bigint_nat_chiffres"][i]
      retenue = tmp // 10;
      chiffres[i] = tmp % 10;
    if chiffres[len - 1] == 0:
      len -= 1
    out_ = {"bigint_nat_len":len, "bigint_nat_chiffres":chiffres}
    return out_;

def mul_bigint_nat( a, b ):
    len = a["bigint_nat_len"] + b["bigint_nat_len"] + 1;
    chiffres = [None] * len
    for k in range(0, len):
      chiffres[k] = 0;
    for i in range(0, a["bigint_nat_len"]):
      for j in range(0, b["bigint_nat_len"]):
        chiffres[i + j] = chiffres[i + j] + b["bigint_nat_chiffres"][j] * a["bigint_nat_chiffres"][i];
    if chiffres[len - 1] == 0:
      len -= 1
    out_ = {"bigint_nat_len":len, "bigint_nat_chiffres":chiffres}
    return out_;

"""
def @bigint exp_bigint(@bigint_nat a, @bigint_nat b)

end
"""
a = read_bigint_nat();
b = read_bigint_nat();
print_bigint_nat(mul_bigint_nat(a, b));
print("")

