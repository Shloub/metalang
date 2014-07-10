def read_int(  ):
    return int(input());

def read_char_line( n ):
    return list(input());

def read_char_matrix( x, y ):
    tab = [None] * y
    for z in range(0, y):
      b = x;
      a = list(input());
      tab[z] = a;
    return tab;

def programme_candidat( tableau, taille_x, taille_y ):
    out_ = 0;
    for i in range(0, taille_y):
      for j in range(0, taille_x):
        out_ += ord(tableau[i][j]) * (i + j * 2)
        print("%c" % tableau[i][j], end='')
      print("--")
    return out_;

c = int(input());
taille_x = c;
d = int(input());
taille_y = d;
tableau = read_char_matrix(taille_x, taille_y);
print("%d\n" % ( programme_candidat(tableau, taille_x, taille_y) ), end='')

