def read_int(  ):
    return int(input());

def read_int_line( n ):
    return list(map(int, input().split()));

def programme_candidat( tableau, taille ):
    out_ = 0;
    for i in range(0, taille):
      out_ += tableau[i]
    return out_;

a = int(input());
taille = a;
c = taille;
b = list(map(int, input().split()));
tableau = b;
print("%d\n" % ( programme_candidat(tableau, taille) ), end='')

