def read_int(  ):
    return int(input());

def read_char_line( n ):
    return list(input());

def programme_candidat( tableau, taille ):
    out_ = 0;
    for i in range(0, taille):
      out_ += ord(tableau[i]) * i
      a = tableau[i];
      print("%c" % a, end='')
    print("--")
    return out_;

taille = read_int();
tableau = read_char_line(taille);
b = programme_candidat(tableau, taille);
print("%d\n" % ( b ), end='')

