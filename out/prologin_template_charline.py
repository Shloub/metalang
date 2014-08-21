def programme_candidat( tableau, taille ):
    out_ = 0;
    for i in range(0, taille):
      out_ += ord(tableau[i]) * i
      print("%c" % tableau[i], end='')
    print("--")
    return out_;

a = int(input());
taille = a;
b = list(input());
tableau = b;
print("%d\n" % ( programme_candidat(tableau, taille) ), end='')

