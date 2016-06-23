
def programme_candidat(tableau, taille_x, taille_y):
    out0 = 0
    for i in range(0, 1 + taille_y - 1):
        for j in range(0, 1 + taille_x - 1):
            out0 += ord(tableau[i][j]) * (i + j * 2)
            print("%c" % tableau[i][j], end='')
        print("--\n", end='')
    return out0

taille_x = int(input())
taille_y = int(input())
a = [None] * taille_y
for b in range(0, 1 + taille_y - 1):
    a[b] = list(input())
tableau = a
print("%d\n" % programme_candidat(tableau, taille_x, taille_y), end='')

