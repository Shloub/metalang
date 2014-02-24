
import sys


def read_int_line( n ):
    a = list(map(int, input().split()));
    return a;

"""
  Ce test a été généré par Metalang.
"""
def result( len, tab ):
    tab2 = [None] * len
    for i in range(0, len):
      tab2[i] = False;
    for i1 in range(0, len):
      tab2[tab[i1]] = True;
    for i2 in range(0, len):
      if not (tab2[i2]):
        return i2;
    return -(1);

l0 = read_int_line(1);
len = l0[0];
tab = read_int_line(len);
b = result(len, tab);
print("%d" % b, end='')

