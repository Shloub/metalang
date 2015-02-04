def programme_candidat( tableau, taille ):
    out0 = 0
    for i in range(0, taille):
      out0 += ord(tableau[i]) * i
      print("%c" % tableau[i], end='')
    print("--")
    return out0

taille = int(input())
tableau = list(input())
print("%d\n" % ( programme_candidat(tableau, taille) ), end='')

