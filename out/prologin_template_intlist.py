def read_int(  ):
    return int(input());

def read_int_line( n ):
    return list(map(int, input().split()));

def programme_candidat( tableau, taille ):
    out_ = 0;
    for i in range(0, taille):
      out_ += tableau[i]
    return out_;

taille = read_int();
tableau = read_int_line(taille);
a = programme_candidat(tableau, taille);
print("%d\n" % ( a ), end='')

