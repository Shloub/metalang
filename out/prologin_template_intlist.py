def programme_candidat( tableau, taille ):
    out_ = 0;
    for i in range(0, taille):
      out_ += tableau[i]
    return out_;

taille = int(input());
tableau = list(map(int, input().split()));
print("%d\n" % ( programme_candidat(tableau, taille) ), end='')

