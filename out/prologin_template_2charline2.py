def programme_candidat( tableau1, taille1, tableau2, taille2 ):
    out_ = 0;
    for i in range(0, taille1):
      out_ += ord(tableau1[i]) * i
      print("%c" % tableau1[i], end='')
    print("--")
    for j in range(0, taille2):
      out_ += ord(tableau2[j]) * j * 100
      print("%c" % tableau2[j], end='')
    print("--")
    return out_;

taille1 = int(input());
taille2 = int(input());
tableau1 = list(input());
tableau2 = list(input());
print("%d\n" % ( programme_candidat(tableau1, taille1, tableau2, taille2) ), end='')

