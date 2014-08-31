def programme_candidat( tableau, x, y ):
    out_ = 0;
    for i in range(0, y):
      for j in range(0, x):
        out_ += tableau[i][j] * (i * 2 + j)
    return out_;

taille_x = int(input());
taille_y = int(input());
tableau = [list(map(int, input().split())) for i in range(taille_y)];
print("%d\n" % ( programme_candidat(tableau, taille_x, taille_y) ), end='')

