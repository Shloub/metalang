
import sys


def read_int_line( n ):
    a = list(map(int, input().split()));
    return a;

l0 = read_int_line(1);
len = l0[0];
print("%d" % len, end='');
print("%s" % "=len\n", end='');
tab1 = read_int_line(len);
for i in range(0, len):
  print("%d" % i, end='');
  print("%s" % "=>", end='');
  b = tab1[i];
  print("%d" % b, end='');
  print("%s" % "\n", end='');
tab2 = read_int_line(len);
for i in range(0, len):
  print("%d" % i, end='');
  print("%s" % "=>", end='');
  c = tab2[i];
  print("%d" % c, end='');
  print("%s" % "\n", end='');

