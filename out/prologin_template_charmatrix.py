def read_char_matrix( x, y ):
    tab = [None] * y
    for z in range(0, y):
      tab[z] = list(input());
    return tab;

def programme_candidat( tableau, taille_x, taille_y ):
    out_ = 0;
    for i in range(0, taille_y):
      for j in range(0, taille_x):
        out_ += ord(tableau[i][j]) * (i + j * 2)
        print("%c" % tableau[i][j], end='')
      print("--")
    return out_;

taille_x = int(input());
taille_y = int(input());
tableau = read_char_matrix(taille_x, taille_y);
print("%d\n" % ( programme_candidat(tableau, taille_x, taille_y) ), end='')

