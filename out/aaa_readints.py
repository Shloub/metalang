
import sys



def read_int_line( n ):
    a = list(map(int, input().split()));
    return a;

def read_int_matrix( x, y ):
    a = [list(map(int, input().split())) for i in range(y)];
    return a;

l0 = read_int_line(1);
len = l0[0];
print("%d%s" % ( len, "=len\n" ), end='');
tab1 = read_int_line(len);
for i in range(0, len):
  print("%d%s" % ( i, "=>" ), end='');
  b = tab1[i];
  print("%d%s" % ( b, "\n" ), end='');
l0 = read_int_line(1);
len = l0[0];
tab2 = read_int_matrix(len, len - 1);
for i in range(0, 1 + len - 2):
  for j in range(0, len):
    c = tab2[i][j];
    print("%d%s" % ( c, " " ), end='');
  print( "\n", end='');

