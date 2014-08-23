def read_int_matrix( x, y ):
    return [list(map(int, input().split())) for i in range(y)];

len = int(input());
print("%d=len\n" % ( len ), end='')
tab1 = list(map(int, input().split()));
for i in range(0, len):
  print("%d=>%d\n" % ( i, tab1[i] ), end='')
len = int(input());
tab2 = read_int_matrix(len, len - 1);
for i in range(0, 1 + len - 2):
  for j in range(0, len):
    print("%d " % ( tab2[i][j] ), end='')
  print("")

