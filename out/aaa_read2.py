import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def read_int(  ):
    return int(input());

def read_int_line( n ):
    return list(map(int, input().split()));

def read_char_line( n ):
    return list(input());

"""
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
"""
a = int(input());
len = a;
print("%d=len\n" % ( len ), end='')
d = len;
b = list(map(int, input().split()));
tab = b;
for i in range(0, len):
  print("%d=>%d " % ( i, tab[i] ), end='')
print("")
f = len;
e = list(map(int, input().split()));
tab2 = e;
for i_ in range(0, len):
  print("%d==>%d " % ( i_, tab2[i_] ), end='')
g = int(input());
strlen = g;
print("%d=strlen\n" % ( strlen ), end='')
k = strlen;
h = list(input());
tab4 = h;
for i3 in range(0, strlen):
  tmpc = tab4[i3];
  c = ord(tmpc);
  print("%c:%d " % ( tmpc, c ), end='')
  if tmpc != ' ':
    c = mod((c - ord('a')) + 13, 26) + ord('a');
  tab4[i3] = c;
for j in range(0, strlen):
  print("%c" % tab4[j], end='')

