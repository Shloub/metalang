import math
def mod(x, y):
  return x - y * math.trunc(x / y)



def read_int(  ):
    return int(input());

def read_int_line( n ):
    return list(map(int, input().split()));

def read_int_matrix( x, y ):
    return [list(map(int, input().split())) for i in range(y)];

len = read_int();
print("%d=len\n" % ( len ), end='')
tab1 = read_int_line(len);
for i in range(0, len):
  print("%d=>" % ( i ), end='')
  a = tab1[i];
  print("%d\n" % ( a ), end='')
len = read_int();
tab2 = read_int_matrix(len, len - 1);
for i in range(0, 1 + len - 2):
  for j in range(0, len):
    b = tab2[i][j];
    print("%d " % ( b ), end='')
  print("")

