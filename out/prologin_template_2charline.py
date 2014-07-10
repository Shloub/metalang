def read_int(  ):
    return int(input());

def read_char_line( n ):
    return list(input());

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

a = int(input());
taille1 = a;
c = taille1;
b = list(input());
tableau1 = b;
d = int(input());
taille2 = d;
f = taille2;
e = list(input());
tableau2 = e;
print("%d\n" % ( programme_candidat(tableau1, taille1, tableau2, taille2) ), end='')

