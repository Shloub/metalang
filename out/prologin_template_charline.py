def programme_candidat( tableau, taille ):
    out_ = 0;
    for i in range(0, taille):
      out_ += ord(tableau[i]) * i
      print("%c" % tableau[i], end='')
    print("--")
    return out_;

taille = int(input());
tableau = list(input());
print("%d\n" % ( programme_candidat(tableau, taille) ), end='')

