
def programme_candidat(tableau, taille):
    out0 = 0
    for i in range(0, 1 + taille - 1):
        out0 += tableau[i]
    return out0

taille = int(input())
tableau = list(map(int, input().split()))
print("%d\n" % programme_candidat(tableau, taille), end='')

