def read_int_matrix( x, y ):
    return [list(map(int, input().split())) for i in range(y)];

a = int(input());
len = a;
print("%d=len\n" % ( len ), end='')
b = list(map(int, input().split()));
tab1 = b;
for i in range(0, len):
  print("%d=>%d\n" % ( i, tab1[i] ), end='')
c = int(input());
len = c;
tab2 = read_int_matrix(len, len - 1);
for i in range(0, 1 + len - 2):
  for j in range(0, len):
    print("%d " % ( tab2[i][j] ), end='')
  print("")

