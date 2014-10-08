def programme_candidat( tableau, taille_x, taille_y ):
    out0 = 0;
    for i in range(0, taille_y):
      for j in range(0, taille_x):
        out0 += ord(tableau[i][j]) * (i + j * 2)
        print("%c" % tableau[i][j], end='')
      print("--")
    return out0;

taille_x = int(input());
taille_y = int(input());
e = [None] * taille_y
for f in range(0, taille_y):
  e[f] = list(input());
tableau = e;
print("%d\n" % ( programme_candidat(tableau, taille_x, taille_y) ), end='')

