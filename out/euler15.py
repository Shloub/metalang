
n = 10
# normalement on doit mettre 20 mais là on se tape un overflow 

n += 1
tab = [None] * n
for i in range(0, 1 + n - 1):
    tab2 = [0] * n
    tab[i] = tab2
for l in range(0, 1 + n - 1):
    tab[n - 1][l] = 1
    tab[l][n - 1] = 1
for o in range(2, 1 + n):
    r = n - o
    for p in range(2, 1 + n):
        q = n - p
        tab[r][q] = tab[r + 1][q] + tab[r][q + 1]
for m in range(0, 1 + n - 1):
    for k in range(0, 1 + n - 1):
        print("%d " % tab[m][k], end='')
    print("\n", end='')
print("%d\n" % tab[0][0], end='')

