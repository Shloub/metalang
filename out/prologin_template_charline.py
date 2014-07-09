def read_int(  ):
    return int(input());

def read_char_line( n ):
    return list(input());

def programme_candidat( tableau, taille ):
    out_ = 0;
    for i in range(0, taille):
      out_ += ord(tableau[i]) * i
      print("%c" % tableau[i], end='')
    print("--")
    return out_;

taille = read_int();
tableau = read_char_line(taille);
print("%d\n" % ( programme_candidat(tableau, taille) ), end='')

