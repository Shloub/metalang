def read_int(  ):
    return int(input());

def read_char_line( n ):
    return list(input());

def read_char_matrix( x, y ):
    tab = [None] * y
    for z in range(0, y):
      tab[z] = read_char_line(x);
    return tab;

def programme_candidat( tableau, taille_x, taille_y ):
    out_ = 0;
    for i in range(0, taille_y):
      for j in range(0, taille_x):
        out_ += ord(tableau[i][j]) * (i + j * 2)
        a = tableau[i][j];
        print("%c" % a, end='')
      print("--")
    return out_;

taille_x = read_int();
taille_y = read_int();
tableau = read_char_matrix(taille_x, taille_y);
b = programme_candidat(tableau, taille_x, taille_y);
print("%d\n" % ( b ), end='')

