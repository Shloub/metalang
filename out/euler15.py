n = 10;
""" normalement on doit mettre 20 mais là on se tape un overflow """
n += 1
tab = [None] * n
for i in range(0, n):
  tab2 = [None] * n
  for j in range(0, n):
    tab2[j] = 0;
  tab[i] = tab2;
for l in range(0, n):
  tab[n - 1][l] = 1;
  tab[l][n - 1] = 1;
for o in range(2, 1 + n):
  r = n - o;
  for p in range(2, 1 + n):
    q = n - p;
    tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
for m in range(0, n):
  for k in range(0, n):
    a = tab[m][k];
    print("%d " % ( a ), end='')
  print("")
b = tab[0][0];
print("%d\n" % ( b ), end='')

