
x = int(input())
y = int(input())
tab = [list(map(int, input().split())) for i in range(y)]
for ix in range(1, 1 + x - 1):
    for iy in range(1, 1 + y - 1):
        if tab[iy][ix] == 1:
            tab[iy][ix] = min(tab[iy][ix - 1], tab[iy - 1][ix], tab[iy - 1][ix - 1]) + 1
for jy in range(0, 1 + y - 1):
    for jx in range(0, 1 + x - 1):
        print("%d " % tab[jy][jx], end='')
    print("\n", end='')

