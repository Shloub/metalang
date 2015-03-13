x = int(input())
y = int(input())
tab = [list(map(int, input().split())) for i in range(y)]
for ix in range(1, x):
  for iy in range(1, y):
    if tab[iy][ix] == 1:
      tab[iy][ix] = min(tab[iy][ix - 1], tab[iy - 1][ix], tab[iy - 1][ix - 1]) + 1
for jy in range(0, y):
  for jx in range(0, x):
    print("%d " % ( tab[jy][jx] ), end='')
  print("")

